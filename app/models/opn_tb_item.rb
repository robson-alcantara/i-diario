class OpnTbItem < ActiveRecord::Base
  belongs_to :opn_tb
  belongs_to :opn_tb_question
  belongs_to :opn_tb_gradation_level
end
