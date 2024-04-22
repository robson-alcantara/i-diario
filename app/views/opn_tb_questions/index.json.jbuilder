json.array!(@opn_tb_questions) do |opn_tb_question|
  json.extract! opn_tb_question, :id, :description, :discipline_id
  json.url opn_tb_question_url(opn_tb_question, format: :json)
end
