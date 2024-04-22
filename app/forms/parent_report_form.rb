class ParentReportForm
  include ActiveModel::Model

  attr_accessor :unity_id,
                :school_calendar_year,
                :current_teacher_id

  validates :unity_id, presence: true
  validates :school_calendar_year, presence: true

  private

  def teacher
    Teacher.find(@current_teacher_id)
  end
end
