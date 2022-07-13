json.array!(@opn_tb_answers_groups_answers) do |opn_tb_answers_groups_answer|
  json.extract! opn_tb_answers_groups_answer, :id, :opn_tb_answers_group_id, :opn_tb_answer_id, :order
  json.url opn_tb_answers_groups_answer_url(opn_tb_answers_groups_answer, format: :json)
end
