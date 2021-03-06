FactoryGirl.define do
  factory :teaching_plan do
    unity
    grade
    teacher

    year { Date.current.year }
    school_term_type SchoolTermTypes::BIMESTER
    school_term Bimesters::FIRST_BIMESTER
    contents { [create(:content)] }

    before(:create) do |teaching_plan, evaluator|
      teaching_plan.contents_created_at_position = {}
      evaluator.contents.each_with_index do |content, index|
        teaching_plan.contents_created_at_position[content.id] = index
      end
    end

    transient do
      classroom nil
      discipline nil
    end

    trait :yearly do
      school_term_type SchoolTermTypes::YEARLY
      school_term ''
    end

    trait :without_contents do
      school_term_type SchoolTermTypes::SEMESTER
      school_term Semesters::FIRST_SEMESTER
      contents []
    end

    trait :with_teacher_discipline_classroom do
      after(:build) do |teaching_plan, evaluator|
        teaching_plan.teacher_id ||= teaching_plan.teacher.id
        classroom = evaluator.classroom || create(:classroom, grade: teaching_plan.grade)
        discipline = evaluator.discipline || create(:discipline)

        teaching_plan.contents_created_at_position = {}
        evaluator.contents.each_with_index do |content, index|
          teaching_plan.contents_created_at_position[content.id] = index
        end

        create(
          :teacher_discipline_classroom,
          teacher: teaching_plan.teacher,
          classroom: classroom,
          discipline: discipline
        )
      end
    end
  end
end
