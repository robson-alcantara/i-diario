class CreateOpnTbItems < ActiveRecord::Migration
  def change
    create_table :opn_tb_items do |t|
      t.references :opn_tb, index: true, foreign_key: true
      t.references :opn_tb_question, index: true, foreign_key: true
      t.references :opn_tb_gradation_level, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
  end
end
