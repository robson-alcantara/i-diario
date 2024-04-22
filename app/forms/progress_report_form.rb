class ProgressReportForm
  include ActiveModel::Model

  attr_accessor :unity_id,
                :classroom_id,
                :school_calendar_year,
                :current_teacher_id,
                #:school_calendar,
                :school_calendar_step_id

  validates :unity_id, presence: true
  validates :classroom_id, presence: true
  validates :school_calendar_year, presence: true
#  validates :school_calendar, presence: true
  validates :school_calendar_step_id, presence: true



  private

  # def step
  #   return unless school_calendar_step_id 


  #     @step ||= SchoolCalendarStep.find(school_calendar_step_id)

  # end

  # def school_calendar
  #     step.school_calendar
  # end

  def classroom
    Classroom.find(@classroom_id)
  end

  def teacher
    Teacher.find(@current_teacher_id)
  end
end
