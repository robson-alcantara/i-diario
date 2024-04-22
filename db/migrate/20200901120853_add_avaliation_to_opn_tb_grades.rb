class AddAvaliationToOpnTbGrades < ActiveRecord::Migration
  def change
    add_column :opn_tb_grades, :avaliation, :boolean
  end
end
