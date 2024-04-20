class CreateFunctionCheckToKeepUniqueDescriptiveExams < ActiveRecord::Migration[4.2]
  def change
    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_descriptive_exam_is_unique(
        _id INT,
        _classroom_id INT,
        _discipline_id INT,
        _recorded_at DATE
      )
        RETURNS BOOLEAN AS
      $$
      DECLARE
        _current_step_id INT;
      BEGIN
        SELECT step_id
          INTO _current_step_id
          FROM step_by_classroom(
                 _classroom_id,
                 _recorded_at
               ) AS step;

        IF NOT EXISTS(
          SELECT 1
            FROM descriptive_exams,
                 step_by_classroom(
                   descriptive_exams.classroom_id,
                   descriptive_exams.recorded_at
                 ) AS step
           WHERE descriptive_exams.classroom_id = _classroom_id
             AND COALESCE(descriptive_exams.discipline_id, 0) = COALESCE(_discipline_id, 0)
             AND step.step_id = _current_step_id
             AND descriptive_exams.id <> _id
        ) THEN
          RETURN TRUE;
        END IF;

        RETURN FALSE;
      END
      $$ LANGUAGE plpgsql;
    SQL
  end
end
