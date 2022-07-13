class AddIndexToOpnTbGrades3 < ActiveRecord::Migration
  def change
    add_index :opn_tb_grades, [:grade_id, :year, :avaliation, :final], unique: true, :name => 'index_opn_tb_grades_on_grade_year_avaliation_final'
  end
end
