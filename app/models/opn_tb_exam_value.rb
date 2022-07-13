class OpnTbExamValue < ActiveRecord::Base
  belongs_to :opn_tb_exam
  belongs_to :opn_tb_item
  belongs_to :opn_tb_answer  
end
