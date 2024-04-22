class MonthlyFrequenciesReportController < ApplicationController
  before_action :require_current_teacher

  def form
    @monthly_frequencies_report_form = MonthlyFrequenciesReportForm.new(
      unity_id: current_user_unity.id,
      school_calendar_year: current_user_school_year
    )
  end

  def report    
    @monthly_frequencies_report_form = MonthlyFrequenciesReportForm.new(resource_params)

    if @monthly_frequencies_report_form.valid?

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
        #puts @monthly_frequencies_report_form.classroom_id
        client.run_ieducar_monitor_progress( "MONTHLY_FREQUENCIES", current_user_unity.id, -1, -1, -1, current_user_school_year, filename )              
        transport.close()
      
      rescue Thrift::Exception => tx
        print 'Thrift::Exception: ', tx.message, "\n"
      end     
      
      send_file filename      
    else
      @monthly_frequencies_report_form.school_calendar_year = current_user_school_year
      fetch_collections
      render :form
    end
  end

  private

  def resource_params
    params.require(:monthly_frequencies_report_form).permit(:unity_id,
                                                          :school_calendar_year)
  end

end