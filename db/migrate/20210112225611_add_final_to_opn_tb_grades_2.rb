class AddFinalToOpnTbGrades2 < ActiveRecord::Migration
  def change
    add_column :opn_tb_grades, :final, :boolean
  end
end
