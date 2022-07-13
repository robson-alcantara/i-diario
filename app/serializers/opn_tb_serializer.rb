class OpnTbSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :opn_tb_answers_group
end
