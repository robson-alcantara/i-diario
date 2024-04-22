class CreateOpnTbQuestions < ActiveRecord::Migration
  def change
    create_table :opn_tb_questions do |t|
      t.text :description
      t.references :discipline, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
