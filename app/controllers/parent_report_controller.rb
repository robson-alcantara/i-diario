class ParentReportController < ApplicationController
  before_action :require_current_teacher

  def form
    @parent_report_form = ParentReportForm.new(
      unity_id: current_user_unity.id,
      school_calendar_year: current_user_school_year
    )
    fetch_collections
  end

  def report    
    @parent_report_form = ParentReportForm.new(resource_params)

    if @parent_report_form.valid?

      $:.push('./app/controllers/thrift/gen-rb')
      $:.unshift '../../lib/rb/lib'
      
      require 'thrift'
      
      require 'calculator'      

      extension = ".pdf" 


      filename = "#{Dir.pwd}/public/relatorios/report#{Time.now.strftime("_%m_%d_%Y_%H-%M-%S")}#{extension}"            
      
      begin
        port = ARGV[0] || 9090
      
        transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', port))
        protocol = Thrift::BinaryProtocol.new(transport)
        client = Calculator::Client.new(protocol)
      
        transport.open()
      
        client.run_ieducar_monitor_progress( "PARENTS", current_user_unity.id, -1, -1, -1, current_user_school_year, filename )              
        transport.close()
      
      rescue Thrift::Exception => tx
        print 'Thrift::Exception: ', tx.message, "\n"
      end      
      
      send_file filename      
    else
      @parent_report_form.school_calendar_year = current_user_school_year
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
    params.require(:parent_report_form).permit(:unity_id,
                                                          :school_calendar_year,
                                                          :current_teacher_id)
  end

end
