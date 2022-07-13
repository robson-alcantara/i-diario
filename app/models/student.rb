class Student < ActiveRecord::Base
  acts_as_copy_target

  audited

  has_one :user

  has_and_belongs_to_many :users

  has_many :student_biometrics
  has_many :student_enrollments
  has_many :absence_justifications
  has_many :avaliation_exemptions
  has_many :complementary_exam_students
  has_many :conceptual_exams
  has_many :daily_frequency_students
  has_many :daily_note_students
  has_many :descriptive_exam_students
  has_many :observation_diary_record_note_students
  has_many :recovery_diary_record_students
  has_many :transfer_notes
  has_many :opn_tb_exams

  attr_accessor :exempted_from_discipline

  validates :name, presence: true
  validates :api_code, presence: true, if: :api?

  scope :api, -> { where(arel_table[:api].eq(true)) }
  scope :ordered, -> { order(:name) }
  scope :order_by_sequence, lambda { |classroom_id, start_date, end_date|
    joins(:student_enrollments)
      .merge(
        StudentEnrollment.by_classroom(classroom_id)
                         .by_date_range(start_date, end_date)
                         .active
                         .ordered
      )
  }

  def self.search(value)
    relation = all

    if value.present?
      relation = relation.where(%Q(
        name ILIKE :text OR api_code = :code
      ), text: "%#{value}%", code: value)
    end

    relation
  end

  def to_s
    return I18n.t('.student.display_name_format', social_name: social_name, name: name) if social_name.present?

    name
  end

  def display_name
    @display_name ||= social_name || name
  end

  def first_name
    display_name.blank? ? '' : display_name.split(' ')[0]
  end

  def average(classroom, discipline, step)
    StudentAverageCalculator.new(self).calculate(classroom, discipline, step)
  end

  def classrooms
    Classroom.joins(:student_enrollment_classrooms).merge(StudentEnrollmentClassroom.by_student(self.id)).uniq
  end
end
