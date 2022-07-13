class OpnTbAnswersGroupsAnswerSerializer < ActiveModel::Serializer
  attributes :id, :order
  has_one :opn_tb_answers_group
  has_one :opn_tb_answer
end
