json.array!(@opn_tb_exams) do |opn_tb_exam|
  json.extract! opn_tb_exam, :id, :classroom_id, :student_id, :opn_tb_id, :recorded_at, :step_number
  json.url opn_tb_exam_url(opn_tb_exam, format: :json)
end
