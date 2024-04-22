class RemoveDuplicatedColumnsFromDailyNotes < ActiveRecord::Migration
  def change
    remove_column :daily_notes, :unity_id
    remove_column :daily_notes, :classroom_id
    remove_column :daily_notes, :discipline_id
  end
end
