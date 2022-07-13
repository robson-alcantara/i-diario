class OpnTbGradeSerializer < ActiveModel::Serializer
  attributes :id, :year
  has_one :opn_tb
  has_one :grade
end
