json.array!(@opn_tb_answers_groups) do |opn_tb_answers_group|
  json.extract! opn_tb_answers_group, :id, :name
  json.url opn_tb_answers_group_url(opn_tb_answers_group, format: :json)
end
