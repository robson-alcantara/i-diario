#
# Autogenerated by Thrift Compiler (0.13.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require_relative 'shared_service'
require_relative 'tutorial_types'

module Calculator
  class Client < ::SharedService::Client 
    include ::Thrift::Client

    def run_ieducar_monitor_daily(mode, school_code, class_code, student_code, year, path)
      send_run_ieducar_monitor_daily(mode, school_code, class_code, student_code, year, path)
      recv_run_ieducar_monitor_daily()
    end

    def send_run_ieducar_monitor_daily(mode, school_code, class_code, student_code, year, path)
      send_message('run_ieducar_monitor_daily', Run_ieducar_monitor_daily_args, :mode => mode, :school_code => school_code, :class_code => class_code, :student_code => student_code, :year => year, :path => path)
    end

    def recv_run_ieducar_monitor_daily()
      result = receive_message(Run_ieducar_monitor_daily_result)
      return
    end

    def run_ieducar_monitor_daily_with_dates(mode, school_code, class_code, student_code, start_at, end_at, year, path)
      send_run_ieducar_monitor_daily_with_dates(mode, school_code, class_code, student_code, start_at, end_at, year, path)
      recv_run_ieducar_monitor_daily_with_dates()
    end

    def send_run_ieducar_monitor_daily_with_dates(mode, school_code, class_code, student_code, start_at, end_at, year, path)
      send_message('run_ieducar_monitor_daily_with_dates', Run_ieducar_monitor_daily_with_dates_args, :mode => mode, :school_code => school_code, :class_code => class_code, :student_code => student_code, :start_at => start_at, :end_at => end_at, :year => year, :path => path)
    end

    def recv_run_ieducar_monitor_daily_with_dates()
      result = receive_message(Run_ieducar_monitor_daily_with_dates_result)
      return
    end

    def run_ieducar_monitor_progress(mode, school_code, course_code, teacher_code, step_number, year, path)
      send_run_ieducar_monitor_progress(mode, school_code, course_code, teacher_code, step_number, year, path)
      recv_run_ieducar_monitor_progress()
    end

    def send_run_ieducar_monitor_progress(mode, school_code, course_code, teacher_code, step_number, year, path)
      send_message('run_ieducar_monitor_progress', Run_ieducar_monitor_progress_args, :mode => mode, :school_code => school_code, :course_code => course_code, :teacher_code => teacher_code, :step_number => step_number, :year => year, :path => path)
    end

    def recv_run_ieducar_monitor_progress()
      result = receive_message(Run_ieducar_monitor_progress_result)
      return
    end

    def test_run(mode, school_code, class_code)
      send_test_run(mode, school_code, class_code)
      recv_test_run()
    end

    def send_test_run(mode, school_code, class_code)
      send_message('test_run', Test_run_args, :mode => mode, :school_code => school_code, :class_code => class_code)
    end

    def recv_test_run()
      result = receive_message(Test_run_result)
      return
    end

    def ping()
      send_ping()
      recv_ping()
    end

    def send_ping()
      send_message('ping', Ping_args)
    end

    def recv_ping()
      result = receive_message(Ping_result)
      return
    end

    def add(num1, num2)
      send_add(num1, num2)
      return recv_add()
    end

    def send_add(num1, num2)
      send_message('add', Add_args, :num1 => num1, :num2 => num2)
    end

    def recv_add()
      result = receive_message(Add_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'add failed: unknown result')
    end

    def calculate(logid, w)
      send_calculate(logid, w)
      return recv_calculate()
    end

    def send_calculate(logid, w)
      send_message('calculate', Calculate_args, :logid => logid, :w => w)
    end

    def recv_calculate()
      result = receive_message(Calculate_result)
      return result.success unless result.success.nil?
      raise result.ouch unless result.ouch.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'calculate failed: unknown result')
    end

    def zip()
      send_zip()
    end

    def send_zip()
      send_oneway_message('zip', Zip_args)
    end
  end

  class Processor < ::SharedService::Processor 
    include ::Thrift::Processor

    def process_run_ieducar_monitor_daily(seqid, iprot, oprot)
      args = read_args(iprot, Run_ieducar_monitor_daily_args)
      result = Run_ieducar_monitor_daily_result.new()
      @handler.run_ieducar_monitor_daily(args.mode, args.school_code, args.class_code, args.student_code, args.year, args.path)
      write_result(result, oprot, 'run_ieducar_monitor_daily', seqid)
    end

    def process_run_ieducar_monitor_daily_with_dates(seqid, iprot, oprot)
      args = read_args(iprot, Run_ieducar_monitor_daily_with_dates_args)
      result = Run_ieducar_monitor_daily_with_dates_result.new()
      @handler.run_ieducar_monitor_daily_with_dates(args.mode, args.school_code, args.class_code, args.student_code, args.start_at, args.end_at, args.year, args.path)
      write_result(result, oprot, 'run_ieducar_monitor_daily_with_dates', seqid)
    end

    def process_run_ieducar_monitor_progress(seqid, iprot, oprot)
      args = read_args(iprot, Run_ieducar_monitor_progress_args)
      result = Run_ieducar_monitor_progress_result.new()
      @handler.run_ieducar_monitor_progress(args.mode, args.school_code, args.course_code, args.teacher_code, args.step_number, args.year, args.path)
      write_result(result, oprot, 'run_ieducar_monitor_progress', seqid)
    end

    def process_test_run(seqid, iprot, oprot)
      args = read_args(iprot, Test_run_args)
      result = Test_run_result.new()
      @handler.test_run(args.mode, args.school_code, args.class_code)
      write_result(result, oprot, 'test_run', seqid)
    end

    def process_ping(seqid, iprot, oprot)
      args = read_args(iprot, Ping_args)
      result = Ping_result.new()
      @handler.ping()
      write_result(result, oprot, 'ping', seqid)
    end

    def process_add(seqid, iprot, oprot)
      args = read_args(iprot, Add_args)
      result = Add_result.new()
      result.success = @handler.add(args.num1, args.num2)
      write_result(result, oprot, 'add', seqid)
    end

    def process_calculate(seqid, iprot, oprot)
      args = read_args(iprot, Calculate_args)
      result = Calculate_result.new()
      begin
        result.success = @handler.calculate(args.logid, args.w)
      rescue ::InvalidOperation => ouch
        result.ouch = ouch
      end
      write_result(result, oprot, 'calculate', seqid)
    end

    def process_zip(seqid, iprot, oprot)
      args = read_args(iprot, Zip_args)
      @handler.zip()
      return
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class Run_ieducar_monitor_daily_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    MODE = 1
    SCHOOL_CODE = 2
    CLASS_CODE = 3
    STUDENT_CODE = 4
    YEAR = 5
    PATH = 6

    FIELDS = {
      MODE => {:type => ::Thrift::Types::STRING, :name => 'mode'},
      SCHOOL_CODE => {:type => ::Thrift::Types::I32, :name => 'school_code'},
      CLASS_CODE => {:type => ::Thrift::Types::I32, :name => 'class_code'},
      STUDENT_CODE => {:type => ::Thrift::Types::I32, :name => 'student_code'},
      YEAR => {:type => ::Thrift::Types::I32, :name => 'year'},
      PATH => {:type => ::Thrift::Types::STRING, :name => 'path'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Run_ieducar_monitor_daily_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Run_ieducar_monitor_daily_with_dates_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    MODE = 1
    SCHOOL_CODE = 2
    CLASS_CODE = 3
    STUDENT_CODE = 4
    START_AT = 5
    END_AT = 6
    YEAR = 7
    PATH = 8

    FIELDS = {
      MODE => {:type => ::Thrift::Types::STRING, :name => 'mode'},
      SCHOOL_CODE => {:type => ::Thrift::Types::I32, :name => 'school_code'},
      CLASS_CODE => {:type => ::Thrift::Types::I32, :name => 'class_code'},
      STUDENT_CODE => {:type => ::Thrift::Types::I32, :name => 'student_code'},
      START_AT => {:type => ::Thrift::Types::STRING, :name => 'start_at'},
      END_AT => {:type => ::Thrift::Types::STRING, :name => 'end_at'},
      YEAR => {:type => ::Thrift::Types::I32, :name => 'year'},
      PATH => {:type => ::Thrift::Types::STRING, :name => 'path'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Run_ieducar_monitor_daily_with_dates_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Run_ieducar_monitor_progress_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    MODE = 1
    SCHOOL_CODE = 2
    COURSE_CODE = 3
    TEACHER_CODE = 4
    STEP_NUMBER = 5
    YEAR = 6
    PATH = 7

    FIELDS = {
      MODE => {:type => ::Thrift::Types::STRING, :name => 'mode'},
      SCHOOL_CODE => {:type => ::Thrift::Types::I32, :name => 'school_code'},
      COURSE_CODE => {:type => ::Thrift::Types::I32, :name => 'course_code'},
      TEACHER_CODE => {:type => ::Thrift::Types::I32, :name => 'teacher_code'},
      STEP_NUMBER => {:type => ::Thrift::Types::I32, :name => 'step_number'},
      YEAR => {:type => ::Thrift::Types::I32, :name => 'year'},
      PATH => {:type => ::Thrift::Types::STRING, :name => 'path'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Run_ieducar_monitor_progress_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Test_run_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    MODE = 1
    SCHOOL_CODE = 2
    CLASS_CODE = 3

    FIELDS = {
      MODE => {:type => ::Thrift::Types::STRING, :name => 'mode'},
      SCHOOL_CODE => {:type => ::Thrift::Types::I32, :name => 'school_code'},
      CLASS_CODE => {:type => ::Thrift::Types::I32, :name => 'class_code'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Test_run_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Ping_args
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Ping_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Add_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    NUM1 = 1
    NUM2 = 2

    FIELDS = {
      NUM1 => {:type => ::Thrift::Types::I32, :name => 'num1'},
      NUM2 => {:type => ::Thrift::Types::I32, :name => 'num2'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Add_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Calculate_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    LOGID = 1
    W = 2

    FIELDS = {
      LOGID => {:type => ::Thrift::Types::I32, :name => 'logid'},
      W => {:type => ::Thrift::Types::STRUCT, :name => 'w', :class => ::Work}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Calculate_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    OUCH = 1

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'},
      OUCH => {:type => ::Thrift::Types::STRUCT, :name => 'ouch', :class => ::InvalidOperation}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Zip_args
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Zip_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end
