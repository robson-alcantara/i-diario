class DropIndexToOpnTbExams2 < ActiveRecord::Migration
  def change
    remove_index :opn_tb_exams, name: "index_opn_tb_exams_on_student_classroom_step"
  end
end
