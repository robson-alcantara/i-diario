class UpdateDailyNoteStatusesView < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW daily_note_statuses AS
      SELECT outer_daily_notes.id AS daily_note_id,
       (CASE WHEN exists(
         SELECT daily_notes.id
			     FROM daily_notes
			    INNER JOIN daily_note_students ON(daily_notes.id = daily_note_students.daily_note_id)
			    WHERE daily_note_students.note IS NULL
            AND daily_note_students.active = 't'
	      AND NOT exists(
          SELECT 1
			      FROM avaliation_exemptions
				   WHERE avaliation_exemptions.avaliation_id = daily_notes.avaliation_id
				     AND avaliation_exemptions.student_id = daily_note_students.student_id)
		         AND daily_notes.id = outer_daily_notes.id) THEN 'incomplete' ELSE 'complete' END) AS status
        FROM daily_notes AS outer_daily_notes;
    SQL
  end

  def down
    execute <<-SQL
      CREATE OR REPLACE VIEW daily_note_statuses AS
      SELECT outer_daily_notes.id AS daily_note_id,
       (CASE WHEN exists(
         SELECT daily_notes.id
			     FROM daily_notes
			    INNER JOIN daily_note_students ON(daily_notes.id = daily_note_students.daily_note_id)
			    WHERE daily_note_students.note IS NULL
	      AND NOT exists(
          SELECT 1
			      FROM avaliation_exemptions
				   WHERE avaliation_exemptions.avaliation_id = daily_notes.avaliation_id
				     AND avaliation_exemptions.student_id = daily_note_students.student_id)
		         AND daily_notes.id = outer_daily_notes.id) THEN 'incomplete' ELSE 'complete' END) AS status
        FROM daily_notes AS outer_daily_notes;
    SQL
  end
end
