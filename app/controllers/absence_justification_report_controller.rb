class AbsenceJustificationReportController < ApplicationController
  before_action :require_current_classroom
  before_action :require_current_teacher

  def form
    @absence_justification_report_form = AbsenceJustificationReportForm.new
    @absence_justification_report_form.unity_id = current_unity.id
    @absence_justification_report_form.current_teacher_id = current_teacher
    @absence_justification_report_form.classroom_id = current_user_classroom.id

    set_options_by_user
  end

  def report
    @absence_justification_report_form = AbsenceJustificationReportForm.new(resource_params)
    @absence_justification_report_form.unity_id = current_unity.id
    @absence_justification_report_form.current_teacher_id = current_teacher
    @absence_justification_report_form.user_id = user_id
    @absence_justification_report_form.school_calendar_year = fetch_school_calendar_by_user

    if @absence_justification_report_form.valid?
      absence_justification_report = AbsenceJustificationReport.build(
        current_entity_configuration,
        @absence_justification_report_form
      )

      send_pdf(t('routes.absence_justification'), absence_justification_report.render)
    else
      clear_invalid_dates
      render :form
    end
  end

  private

  def resource_params
    params.require(:absence_justification_report_form).permit(
      :unity,
      :classroom_id,
      :discipline_id,
      :absence_date,
      :absence_date_end,
      :school_calendar_year,
      :current_teacher_id,
      :author
    )
  end

  def clear_invalid_dates
    begin
      resource_params[:absence_date].to_date
    rescue ArgumentError
      @absence_justification_report_form.absence_date = ''
    end

    begin
      resource_params[:absence_date_end].to_date
    rescue ArgumentError
      @absence_justification_report_form.absence_date_end = ''
    end
  end

  def user_id
    @user_id ||= UserDiscriminatorService.new(
      current_user,
      current_user.current_role_is_admin_or_employee?
    ).user_id
  end

  def fetch_school_calendar_by_user
    if current_user.current_role_is_admin_or_employee?
      current_school_calendar
    else
      classroom = Classroom.find(@absence_justification_report_form.classroom_id)

      CurrentSchoolCalendarFetcher.new(current_unity, classroom, current_school_year).fetch
    end
  end

  def set_options_by_user
    if current_user.current_role_is_admin_or_employee?
      @absence_justification_report_form.school_calendar_year = current_school_calendar
    else
      fetch_linked_by_teacher
    end
  end

  def fetch_linked_by_teacher
    @fetch_linked_by_teacher ||= TeacherClassroomAndDisciplineFetcher.fetch!(current_teacher.id, current_unity, current_school_year)
    @disciplines ||= @fetch_linked_by_teacher[:disciplines]
    @classrooms ||= @fetch_linked_by_teacher[:classrooms]
  end
end
