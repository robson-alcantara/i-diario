class DropIndexToOpnTbExams < ActiveRecord::Migration
  def change
    remove_index :opn_tb_exams, name: "index_opn_tb_exams_on_student_id_and_step_number"
  end
end
