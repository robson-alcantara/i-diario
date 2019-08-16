class AbsenceJustificationReportForm
  include ActiveModel::Model

  attr_accessor :unity_id,
                :classroom_id,
                :discipline_ids,
                :absence_date,
                :absence_date_end,
                :school_calendar_year,
                :current_teacher_id,
                :author

  validates :absence_date, presence: true, date: true, not_in_future: true, timeliness: { on_or_before: :absence_date_end, type: :date, on_or_before_message: 'não pode ser maior que a Data final' }
  validates :absence_date_end, presence: true, date: true, not_in_future: true, timeliness: { on_or_after: :absence_date, type: :date, on_or_after_message: 'deve ser maior ou igual a Data inicial' }
  validates :unity_id,         presence: true
  validates :classroom_id,     presence: true

  validate :at_least_one_discipline, if: :frequence_type_by_discipline?
  validate :must_find_absence

  def absence_justification
    if frequence_type_by_discipline?
      AbsenceJustification.by_author(author, current_teacher_id)
                          .by_unity(unity_id)
                          .by_school_calendar_report(school_calendar_year)
                          .by_classroom(classroom_id)
                          .by_disciplines(discipline_ids)
                          .by_date_range(absence_date, absence_date_end)
                          .uniq
                          .ordered
    else
      AbsenceJustification.by_author(author, current_teacher_id)
                          .by_unity(unity_id)
                          .by_school_calendar_report(school_calendar_year)
                          .by_classroom(classroom_id)
                          .by_date_range(absence_date, absence_date_end)
                          .ordered
    end
  end

  def frequence_type_by_discipline?
    frequency_type_definer = FrequencyTypeDefiner.new(classroom, current_teacher_id)
    frequency_type_definer.define!
    frequency_type_definer.frequency_type == FrequencyTypes::BY_DISCIPLINE
  end

  private

  def must_find_absence
    return if errors.present?

    errors.add(:base, 'Não foram encontrados resultados para a pesquisa!') if absence_justification.blank?
  end

  def classroom
    Classroom.find(classroom_id) if classroom_id.present?
  end

  def at_least_one_discipline
    errors.add(:base, :at_least_one_discipline) if discipline_ids.blank?
  end
end
