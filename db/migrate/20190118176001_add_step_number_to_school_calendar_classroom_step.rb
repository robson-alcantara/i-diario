class AddStepNumberToSchoolCalendarClassroomStep < ActiveRecord::Migration
  def change
    add_column :school_calendar_classroom_steps, :step_number, :integer, null: false, default: 0
  end
end
