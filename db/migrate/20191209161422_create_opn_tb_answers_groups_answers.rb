class CreateOpnTbAnswersGroupsAnswers < ActiveRecord::Migration
  def change
    create_table :opn_tb_answers_groups_answers do |t|
      t.references :opn_tb_answers_group, index: true, foreign_key: true
      t.references :opn_tb_answer, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
  end
end
