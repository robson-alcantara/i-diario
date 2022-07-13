class AddIndexToOpnTbExamValues < ActiveRecord::Migration
  def change
    add_index :opn_tb_exam_values, [:opn_tb_exam_id, :opn_tb_item_id], unique: true
  end
end
