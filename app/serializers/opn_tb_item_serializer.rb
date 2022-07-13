class OpnTbItemSerializer < ActiveModel::Serializer
  attributes :id, :order
  has_one :opn_tb
  has_one :opn_tb_question
  has_one :opn_tb_gradation_level
end
