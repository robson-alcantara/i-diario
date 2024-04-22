class ConsolidatedProgressReportController < ApplicationController
  #before_action :require_current_teacher

  def form
    @consolidated_progress_report_form = ConsolidatedProgressReportForm.new(
      unity_id: current_user_unity.id,
      school_calendar_year: current_user_school_year
    )
    @consolidated_progress_report_form.classroom_id = current_user.current_classroom_id
    @course = Course.where( id: Grade.where( id: Classroom.where( id: @consolidated_progress_report_form.classroom_id ).first.grade_id ).first.course_id ).first
    fetch_collections
  end

  def report    
    @consolidated_progress_report_form = ConsolidatedProgressReportForm.new(resource_params)
#    @consolidated_progress_report_form.school_calendar = SchoolCalendar.find_by(unity: current_user_unity, year: current_user_school_year)
    @consolidated_progress_report_form.classroom_id = current_user.current_classroom_id
    @course = Course.where( id: Grade.where( id: Classroom.where( id: @consolidated_progress_report_form.classroom_id ).first.grade_id ).first.course_id ).first
    puts "curso: #{@course.description}"
    @step_number = SchoolCalendarStep.find( @consolidated_progress_report_form.school_calendar_step_id ).step_number

    if @consolidated_progress_report_form.valid?

      $:.push('./app/controllers/thrift/gen-rb')
      $:.unshift '../../lib/rb/lib'
      
      require 'thrift'
      
      require 'calculator'

      extension = ".xls"        

      filename = "#{Dir.pwd}/public/relatorios/report#{Time.now.strftime("_%m_%d_%Y_%H-%M-%S")}#{extension}"            
      
      begin
        port = ARGV[0] || 9090
      
        transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', port))
        protocol = Thrift::BinaryProtocol.new(transport)
        client = Calculator::Client.new(protocol)
      
        transport.open()
      


        #filename = "public/relatorios/report#{Time.now.strftime("_%m_%d_%Y_%H-%M-%S")}#{extension}"      
        #puts "sala de aula: "
        #puts @consolidated_progress_report_form.classroom_id
        client.run_ieducar_monitor_progress( "DATA_PROGRESS_REPORT", -1, -1, -1, @step_number, current_user_school_year, filename )              
        transport.close()
      
      rescue Thrift::Exception => tx
        print 'Thrift::Exception: ', tx.message, "\n"
      end     
      
      send_file filename      
    else
      @consolidated_progress_report_form.school_calendar_year = current_user_school_year
      fetch_collections
      render :form
    end
  end

  private

  def fetch_collections
    @number_of_classes = current_school_calendar.number_of_classes
    @teacher = current_teacher    
  end

  def school_calendar_steps
    @school_calendar_steps ||= SchoolCalendarStep.where(school_calendar: current_school_calendar).includes(:school_calendar)
  end
  helper_method :school_calendar_steps  

  def school_calendar_steps_ordered
    school_calendar_steps.ordered
  end
  helper_method :school_calendar_steps_ordered


  def resource_params
    params.require(:consolidated_progress_report_form).permit(:unity_id,
                                                          :classroom_id,
                                                          :school_calendar_year,
                                                          :current_teacher_id,
                                                          :school_calendar_step_id)
  end

end
