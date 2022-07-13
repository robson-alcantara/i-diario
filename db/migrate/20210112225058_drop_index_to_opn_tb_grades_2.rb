class DropIndexToOpnTbGrades2 < ActiveRecord::Migration
  def change
    remove_index :opn_tb_grades, name: "index_opn_tb_grades_on_grade_id_and_year_and_avaliation"
  end
end
