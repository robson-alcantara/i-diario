json.array!(@opn_tb_grades) do |opn_tb_grade|
  json.extract! opn_tb_grade, :id, :opn_tb_id, :grade_id, :year
  json.url opn_tb_grade_url(opn_tb_grade, format: :json)
end
