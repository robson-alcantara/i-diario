class AddIndexToOpnTbGrades < ActiveRecord::Migration
  def change
    add_index :opn_tb_grades, [:grade_id, :year, :avaliation], unique: true
  end
end
