class CreateOpnTbs < ActiveRecord::Migration
  def change
    create_table :opn_tbs do |t|
      t.string :description
      t.references :opn_tb_answers_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
