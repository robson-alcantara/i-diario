class AddIndexToOpnTbExams < ActiveRecord::Migration
  def change
    add_index :opn_tb_exams, [:student_id, :classroom_id, :step_number], unique: true, :name => 'index_opn_tb_exams_on_student_classroom_step'
  end
end
