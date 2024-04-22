json.array!(@opn_tb_gradation_levels) do |opn_tb_gradation_level|
  json.extract! opn_tb_gradation_level, :id, :initials, :description
  json.url opn_tb_gradation_level_url(opn_tb_gradation_level, format: :json)
end
