class OpnTbExamValueSerializer < ActiveModel::Serializer
  attributes :id
  has_one :opn_tb_exam
  has_one :opn_tb_item
  has_one :opn_tb_answer
end
