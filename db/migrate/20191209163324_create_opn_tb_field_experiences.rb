class CreateOpnTbFieldExperiences < ActiveRecord::Migration
  def change
    create_table :opn_tb_field_experiences do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
