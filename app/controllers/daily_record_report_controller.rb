class DailyRecordReportController < ApplicationController
  before_action :require_current_teacher

  def form
    @daily_record_report_form = DailyRecordReportForm.new(
      unity_id: current_user_unity.id,
      period: current_teacher_period,
      school_calendar_year: current_user_school_year
    )
    fetch_collections
  end

  def editable_report
    @report_type = "DAILY_EDITABLE"
    @extension = ".doc"

    report
  end

  def readonly_report
    @report_type = "DAILY_READONLY"    
    @extension = ".pdf"

    report    
  end

  def report    
    @daily_record_report_form = DailyRecordReportForm.new(resource_params)
    @daily_record_report_form.school_calendar = SchoolCalendar.find_by(unity: current_user_unity, year: current_user_school_year)

    if @daily_record_report_form.valid?
      #daily_record_report = DailyRecordReport.build(current_entity_configuration,
      #                                                        current_teacher,
      #                                                        current_user_school_year,
      #                                                        @daily_record_report_form.start_at,
      #                                                        @daily_record_report_form.end_at,
      #                                                        @daily_record_report_form.daily_frequencies,
      #                                                        @daily_record_report_form.students_enrollments,
      #                                                        @daily_record_report_form.school_calendar_events,
      #                                                        current_school_calendar)
      #send_pdf(t("routes.daily_record"), daily_record_report.render)

      $:.push('./app/controllers/thrift/gen-rb')
      $:.unshift '../../lib/rb/lib'
      
      require 'thrift'
      
      require 'calculator'      
        
      if ( current_user_school_year == 2019 )
        @report_type = "DAILY_EDITABLE"
        @extension = ".xls"        
      end

      filename = "#{Dir.pwd}/public/relatorios/report#{Time.now.strftime("_%m_%d_%Y_%H-%M-%S")}#{@extension}"            
      
      begin
        port = ARGV[0] || 9090
      
        transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', port))
        protocol = Thrift::BinaryProtocol.new(transport)
        client = Calculator::Client.new(protocol)
      
        transport.open()      

        client.run_ieducar_monitor_daily( @report_type, current_user_unity.id, @daily_record_report_form.classroom_id.to_i, @daily_record_report_form.student_id.to_i, current_user_school_year, filename )              
        transport.close()
      
      rescue Thrift::Exception => tx
        print 'Thrift::Exception: ', tx.message, "\n"
      end      
      
      send_file filename      
    else
      @daily_record_report_form.school_calendar_year = current_user_school_year
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
    params.require(:daily_record_report_form).permit(:unity_id,
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
      @daily_record_report_form.start_at = ''
    end

    begin
      resource_params[:end_at].to_date
    rescue ArgumentError
      @daily_record_report_form.end_at = ''
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
    classroom_id = params['classroom_id'].presence || @daily_record_report_form.classroom_id

#    @students_by_daily_note ||= Student.where(
#      id: DailyNoteStudent.by_classroom_id(classroom_id)
#                          .by_test_date_between(
#                            current_school_calendar.first_day,
#                            current_school_calendar.last_day
#                          )
#                          .select(:student_id)
#    ).ordered

    @students_by_daily_note = []
    @student_enrollments = StudentEnrollment.joins(:student_enrollment_classrooms).where(student_enrollment_classrooms: { classroom_id: current_user_classroom })
    @student_ids = @student_enrollments.collect(&:student_id)
    @students_by_daily_note = Student.where(id: @student_ids)

    respond_with @students_by_daily_note if params['classroom_id'].present?

    @students_by_daily_note
  end  
end
