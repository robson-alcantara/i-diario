class CreateOpnTbGrades < ActiveRecord::Migration
  def change
    create_table :opn_tb_grades do |t|
      t.references :opn_tb, index: true, foreign_key: true
      t.references :grade, index: true, foreign_key: true
      t.integer :year

      t.timestamps null: false
    end
  end
end
