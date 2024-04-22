class AddIndexToOpnTbGrade < ActiveRecord::Migration
  def change
    add_index :opn_tb_grades, [:grade_id, :year], unique: true
  end
end
