class MinutesOfFinalResultsReportController < ApplicationController
  before_action :require_current_teacher

  def form
    @minutes_of_final_results_report_form = MinutesOfFinalResultsReportForm.new(
      unity_id: current_user_unity.id,
      school_calendar_year: current_user_school_year
    )
    @minutes_of_final_results_report_form.classroom_id = current_user.current_classroom_id
    @course = Course.where( id: Grade.where( id: Classroom.where( id: @minutes_of_final_results_report_form.classroom_id ).first.grade_id ).first.course_id ).first
    fetch_collections
  end

  def report
    @minutes_of_final_results_report_form = MinutesOfFinalResultsReportForm.new(resource_params)
#    @minutes_of_final_results_report_form.school_calendar = SchoolCalendar.find_by(unity: current_user_unity, year: current_user_school_year)
    @minutes_of_final_results_report_form.classroom_id = current_user.current_classroom_id
    @course = Course.where( id: Grade.where( id: Classroom.where( id: @minutes_of_final_results_report_form.classroom_id ).first.grade_id ).first.course_id ).first        

    if @minutes_of_final_results_report_form.valid?

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

        client.run_ieducar_monitor_daily( "MINUTES_OF_FINAL_RESULTS_SHEETS", current_user_unity.id, @minutes_of_final_results_report_form.classroom_id.to_i, -1, current_user_school_year, filename )              
        transport.close()
      
      rescue Thrift::Exception => tx
        print 'Thrift::Exception: ', tx.message, "\n"
      end     
      
      send_file filename      
    else
      @minutes_of_final_results_report_form.school_calendar_year = current_user_school_year
      fetch_collections
      render :form
    end
  end

  private

  def fetch_collections
    @number_of_classes = current_school_calendar.number_of_classes
    @teacher = current_teacher    
  end

  def resource_params
    params.require(:minutes_of_final_results_report_form).permit(:unity_id,
                                                          :classroom_id,
                                                          :school_calendar_year,
                                                          :current_teacher_id)
  end

end
