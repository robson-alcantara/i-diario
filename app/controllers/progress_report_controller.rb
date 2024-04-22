class ProgressReportController < ApplicationController
  # before_action :require_current_teacher

  def form
    @progress_report_form = ProgressReportForm.new(
      unity_id: current_user_unity.id,
      school_calendar_year: current_user_school_year
    )    

    if( current_user.current_classroom_id != nil ) 
      @progress_report_form.classroom_id = current_user.current_classroom_id
      @course = Course.where( id: Grade.where( id: Classroom.where( id: @progress_report_form.classroom_id ).first.grade_id ).first.course_id ).first
    else
      @progress_report_form.classroom_id = -1
      @course = Course.new       
    end
    fetch_collections
  end

  def report    
    @progress_report_form = ProgressReportForm.new(resource_params)
#    @progress_report_form.school_calendar = SchoolCalendar.find_by(unity: current_user_unity, year: current_user_school_year)

    if( current_user.current_classroom_id != nil ) 
      @progress_report_form.classroom_id = current_user.current_classroom_id
      @course = Course.where( id: Grade.where( id: Classroom.where( id: @progress_report_form.classroom_id ).first.grade_id ).first.course_id ).first
    else
      @progress_report_form.classroom_id = -1
      @course = Course.new  
      @course.id = -1     
    end    
    
    @step_number = SchoolCalendarStep.find( @progress_report_form.school_calendar_step_id ).step_number

    if @progress_report_form.valid?

      $:.push('./app/controllers/thrift/gen-rb')
      $:.unshift '../../lib/rb/lib'
      
      require 'thrift'
      
      require 'calculator'

      extension = ".txt"        

      filename = "#{Dir.pwd}/public/relatorios/report#{Time.now.strftime("_%m_%d_%Y_%H-%M-%S")}#{extension}"            
      
      begin
        port = ARGV[0] || 9090
      
        transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', port))
        protocol = Thrift::BinaryProtocol.new(transport)
        client = Calculator::Client.new(protocol)
      
        transport.open()

        client.run_ieducar_monitor_progress( "PENDINGS", current_user_unity.id, @course.id.to_i, current_teacher_id, @step_number, current_user_school_year, filename )              
        transport.close()
      
      rescue Thrift::Exception => tx
        print 'Thrift::Exception: ', tx.message, "\n"
      end     
      
      send_file filename      
    else
      @progress_report_form.school_calendar_year = current_user_school_year
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
    params.require(:progress_report_form).permit(:unity_id,
                                                          :classroom_id,
                                                          :school_calendar_year,
                                                          :current_teacher_id,
                                                          :school_calendar_step_id)
  end

end
