json.array!(@opn_tb_field_experiences) do |opn_tb_field_experience|
  json.extract! opn_tb_field_experience, :id, :description
  json.url opn_tb_field_experience_url(opn_tb_field_experience, format: :json)
end
