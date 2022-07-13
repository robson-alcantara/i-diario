class OpnTbQuestionSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :discipline
end
