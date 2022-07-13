json.array!(@opn_tb_answers) do |opn_tb_answer|
  json.extract! opn_tb_answer, :id, :initials, :description
  json.url opn_tb_answer_url(opn_tb_answer, format: :json)
end
