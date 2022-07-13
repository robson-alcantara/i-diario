json.array!(@opn_tb_items) do |opn_tb_item|
  json.extract! opn_tb_item, :id, :opn_tb_id, :opn_tb_question_id, :opn_tb_gradation_level_id, :order
  json.url opn_tb_item_url(opn_tb_item, format: :json)
end
