class CreateOpnTbExams < ActiveRecord::Migration
  def change
    create_table :opn_tb_exams do |t|
      t.references :classroom, index: true, foreign_key: true, null: false
      t.references :student, index: true, foreign_key: true, null: false
      t.references :opn_tb, index: true, foreign_key: true, null: false
      t.date :recorded_at, null: false
      t.integer :step_number, null: false

      t.timestamps null: false
    end
  end
end
