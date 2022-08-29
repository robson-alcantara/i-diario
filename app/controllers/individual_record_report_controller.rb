class IndividualRecordReportController < ApplicationController
  before_action :require_current_teacher

  def form
    @individual_record_report_form = IndividualRecordReportForm.new(
      unity_id: current_user_unity.id,
      period: current_teacher_period,
      school_calendar_year: current_user_school_year
    )
    fetch_collections
  end

  def editable_report
    @report_type = "INDIVIDUAL_RECORDS_EDITABLE"
    @extension = ".docx"

    report
  end

  def readonly_report
    @report_type = "INDIVIDUAL_RECORDS_READONLY"    
    @extension = ".pdf"

    report    
  end  

  def report    
    @individual_record_report_form = IndividualRecordReportForm.new(resource_params)
    @individual_record_report_form.school_calendar = SchoolCalendar.find_by(unity: current_user_unity, year: current_user_school_year)

    if @individual_record_report_form.valid?
      
      $:.push('./app/controllers/thrift/gen-rb')
      $:.unshift '../../lib/rb/lib'
      
      require 'thrift'
      
      require 'calculator'      

      extension = ""

      grade_api_code = Grade.find( Classroom.find( current_user_classroom ).grade_id ).api_code
        
      if ( ( grade_api_code.to_i != 38 ) &&
        ( grade_api_code.to_i != 39 ) &&
        ( grade_api_code.to_i != 40 ) &&
        ( grade_api_code.to_i != 41 ) &&
        ( grade_api_code.to_i != 42 ) )
        @extension = ".xls"
        @report_type = "INDIVIDUAL_RECORDS_EDITABLE"
      end

      filename = "#{Dir.pwd}/public/relatorios/report#{Time.now.strftime("_%m_%d_%Y_%H-%M-%S")}#{@extension}"            
      
      begin
        port = ARGV[0] || 9090
      
        transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', port))
        protocol = Thrift::BinaryProtocol.new(transport)
        client = Calculator::Client.new(protocol)

        if ( ( grade_api_code.to_i === 38 ) ||
          ( grade_api_code.to_i === 39 ) ||
          ( grade_api_code.to_i === 40 ) ||
          ( grade_api_code.to_i === 41 ) ||
          ( grade_api_code.to_i === 42 ) )
          transport.open()
      
          client.run_ieducar_monitor_daily_with_dates( @report_type, current_user_unity.id, @individual_record_report_form.classroom_id.to_i, @individual_record_report_form.student_id.to_i, @individual_record_report_form.start_at, @individual_record_report_form.end_at, current_user_school_year, filename )              
          transport.close()
        else
          transport.open()
      
          client.run_ieducar_monitor_daily( @report_type, current_user_unity.id, @individual_record_report_form.classroom_id.to_i, @individual_record_report_form.student_id.to_i, current_user_school_year, filename )              
          transport.close()
        end      
      rescue Thrift::Exception => tx
        print 'Thrift::Exception: ', tx.message, "\n"
      end      
      
      send_file filename      
    else
      @individual_record_report_form.school_calendar_year = current_user_school_year
      fetch_collections
      clear_invalid_dates
      render :form
    end
  end

  private

  def fetch_collections
    @number_of_classes = current_school_calendar.number_of_classes
    @teacher = current_teacher
  end

  def resource_params
    params.require(:individual_record_report_form).permit(:unity_id,
                                                          :classroom_id,
                                                          :student_id,
                                                          :period,
                                                          :start_at,
                                                          :end_at,
                                                          :school_calendar_year,
                                                          :current_teacher_id)
  end

  def clear_invalid_dates
    begin
      resource_params[:start_at].to_date
    rescue ArgumentError
      @individual_record_report_form.start_at = ''
    end

    begin
      resource_params[:end_at].to_date
    rescue ArgumentError
      @individual_record_report_form.end_at = ''
    end
  end

  def current_teacher_period
    TeacherPeriodFetcher.new(
      current_teacher.id,
      current_user.current_classroom_id,
      current_user.current_discipline_id
    ).teacher_period
  end

  def students
    students_by_daily_note
  end
  helper_method :students
  
  def students_by_daily_note
    classroom_id = params['classroom_id'].presence || @individual_record_report_form.classroom_id

    @students_by_daily_note = []

    @student_enrollments = StudentEnrollment.joins(:student_enrollment_classrooms)
    .where(student_enrollment_classrooms: { classroom_id: current_user_classroom })
    .where("(select count(*) from student_enrollment_dependences where student_enrollment_id = student_enrollments.id) = 0") # elimina os alunos com dependência

    @student_ids = @student_enrollments.collect(&:student_id)
    @students_by_daily_note = Student.where(id: @student_ids)

    respond_with @students_by_daily_note if params['classroom_id'].present?

    @students_by_daily_note
  end  
end
