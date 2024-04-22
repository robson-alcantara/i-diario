class MonthlyFrequenciesReportForm
  include ActiveModel::Model

  attr_accessor :unity_id,
                :school_calendar_year

  validates :unity_id, presence: true
  validates :school_calendar_year, presence: true

end
