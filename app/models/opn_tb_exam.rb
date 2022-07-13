class OpnTbExam < ActiveRecord::Base
  #include Stepable

  belongs_to :classroom
  belongs_to :student
  belongs_to :opn_tb
  has_many :opn_tb_exam_values
  accepts_nested_attributes_for :opn_tb_exam_values, allow_destroy: true 

  validates :student, uniqueness: { scope: [:step_number, :classroom_id, :opn_tb_id], notice: "pode haver apenas uma tabela do aluno por bimestre"}

  #validates :validate_classroom, only: [:show, :create, :edit, :update, :destroy]
  #validates :current_user_classroom, numericality: { equal_to: 4 }

  #def validate_classroom
  #  if Grade.find_by( id: Classroom.find_by( id: current_user_classroom ).grade_id ) != 4   
  #    errors.add(:current_user_classroom, "Turma sem tabela de parecer")
  #  end
  #end   
end
