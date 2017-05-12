class LessonPlan < ActiveRecord::Base
  include Audit

  acts_as_copy_target

  attr_writer :contents_tags

  audited except: [:teacher_id, :old_contents]
  has_associated_audits

  belongs_to :school_calendar
  belongs_to :unity
  belongs_to :classroom

  has_one :discipline_lesson_plan
  has_one :knowledge_area_lesson_plan
<<<<<<< HEAD

  has_many :contents_lesson_plans, dependent: :destroy
  has_many :contents, through: :contents_lesson_plans
=======
  has_and_belongs_to_many :contents, dependent: :restrict
  has_many :lesson_plan_attachments, dependent: :destroy
>>>>>>> master
  accepts_nested_attributes_for :contents, allow_destroy: true
  accepts_nested_attributes_for :lesson_plan_attachments, allow_destroy: true

  validates :school_calendar, presence: true
  validates :unity, presence: true
  validates :classroom, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  validate :crescent_date_range
  validate :at_least_one_assigned_content

  def contents_tags
    if @contents_tags.present?
      ContentTagConverter::tags_to_json(@contents_tags)
    else
      ContentTagConverter::contents_to_json(contents_ordered)
    end
  end

  def contents_ordered
    contents.order(' "contents_lesson_plans"."id" ')
  end

  private

  def crescent_date_range
    return if start_at.nil? or end_at.nil?
    if start_at > end_at
      errors.add(:start_at)
      errors.add(:end_at)
      errors.add(:base, :crescent_date_range)
    end
  end

  def at_least_one_assigned_content
    errors.add(:contents, :at_least_one_content) if contents.empty?
  end
end
