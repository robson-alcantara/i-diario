class AddIndexToOpnTbExams2 < ActiveRecord::Migration
  def change
    add_index :opn_tb_exams, [:student_id, :opn_tb_id, :classroom_id, :step_number], unique: true, :name => 'index_opn_tb_exams_on_student_opntb_classroom_step'
  end
end
