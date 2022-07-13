json.array!(@opn_tb_exam_values) do |opn_tb_exam_value|
  json.extract! opn_tb_exam_value, :id, :opn_tb_exam_id, :opn_tb_item_id, :opn_tb_answer_id
  json.url opn_tb_exam_value_url(opn_tb_exam_value, format: :json)
end
