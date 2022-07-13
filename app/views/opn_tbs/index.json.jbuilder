json.array!(@opn_tbs) do |opn_tb|
  json.extract! opn_tb, :id, :description, :opn_tb_answers_group_id
  json.url opn_tb_url(opn_tb, format: :json)
end
