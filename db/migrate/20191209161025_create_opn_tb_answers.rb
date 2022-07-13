class CreateOpnTbAnswers < ActiveRecord::Migration
  def change
    create_table :opn_tb_answers do |t|
      t.string :initials, limit: 5
      t.string :description

      t.timestamps null: false
    end
  end
end
