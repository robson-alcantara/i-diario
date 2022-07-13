class CreateOpnTbExamValues < ActiveRecord::Migration
  def change
    create_table :opn_tb_exam_values do |t|
      t.references :opn_tb_exam, index: true, foreign_key: {on_delete: :cascade}, null: false
      t.references :opn_tb_item, index: true, foreign_key: true, null: false
      t.references :opn_tb_answer, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
