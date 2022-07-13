class OpnTbExamSerializer < ActiveModel::Serializer
  attributes :id, :recorded_at, :step_number
  has_one :classroom
  has_one :student
  has_one :opn_tb
end
