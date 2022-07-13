class CreateOpnTbAnswersGroups < ActiveRecord::Migration
  def change
    create_table :opn_tb_answers_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
