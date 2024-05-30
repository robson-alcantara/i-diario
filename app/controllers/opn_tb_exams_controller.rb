class OpnTbExamsController < ApplicationController
  before_action :set_opn_tb_exam, only: [:show, :edit, :update, :destroy]  

  # GET /opn_tb_exams
  # GET /opn_tb_exams.json
  def index
    @opn_tb_exams = OpnTbExam.where( classroom_id: current_user_classroom )
  end

  # GET /opn_tb_exams/1
  # GET /opn_tb_exams/1.json
  def show
  end

  # GET /opn_tb_exams/new
  def new
    @avaliation = true
    @final = false
    new_partial
  end

  # GET /opn_tb_exams/new_asp
  def new_asp
    @avaliation = false
    @final = false
    new_partial
  end  

  # GET /opn_tb_exams/new_final
  def new_final
    @avaliation = true
    @final = true
    new_partial
  end   

  # GET /opn_tb_exams/1/edit
  def edit
    fetch_collections
    @opn_tb_exam = OpnTbExam.find(params[:id])
    @opn_tb_exam.opn_tb_exam_values.build if @opn_tb_exam.opn_tb_exam_values.blank?
    @opn_tb = OpnTb.find( @opn_tb_exam.opn_tb_id )    
    @opn_tb_items = OpnTbItem.where( opn_tb_id: @opn_tb.id  ).order( :order )

    @opn_tb_items_hash = {}

    @opn_tb_items.each do |x|
      @opn_tb_items_hash[OpnTbQuestion.find_by( id: x.opn_tb_question_id ).description] = x.id
    end    
    @opn_tb_aswers = OpnTbAnswer.where( id: OpnTbAnswersGroupsAnswer.where( opn_tb_answers_group_id: @opn_tb.opn_tb_answers_group_id ).select( :opn_tb_answer_id ) )
  end

  # POST /opn_tb_exams
  # POST /opn_tb_exams.json
  def create
    @opn_tb_exam = OpnTbExam.new(opn_tb_exam_params)

    respond_to do |format|
      if @opn_tb_exam.save
        format.html { redirect_to @opn_tb_exam, notice: 'A tabela de pareceres foi criada com sucesso' }
        format.json { render :show, status: :created, location: @opn_tb_exam }
      else
        if @avaliation
          new
          format.html { render :new, notice: @opn_tb_exam.errors.full_messages }
          format.json { render json: @opn_tb_exam.errors, status: :unprocessable_entity }
        elsif @final
          new_final
          format.html { render :new_final, notice: @opn_tb_exam.errors.full_messages }
          format.json { render json: @opn_tb_exam.errors, status: :unprocessable_entity }          
        else
          new_asp
          format.html { render :new_asp, notice: @opn_tb_exam.errors.full_messages }
          format.json { render json: @opn_tb_exam.errors, status: :unprocessable_entity }                  
        end
      #render action: "new"
      end
    end
  end

  # PATCH/PUT /opn_tb_exams/1
  # PATCH/PUT /opn_tb_exams/1.json
  def update
    respond_to do |format|
      if @opn_tb_exam.update(opn_tb_exam_params)
        format.html { redirect_to @opn_tb_exam, notice: 'A tabela de pareceres foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @opn_tb_exam }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_exams/1
  # DELETE /opn_tb_exams/1.json
  def destroy
    @opn_tb_exam.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_exams_url, notice: 'A tabela de pareceres foi removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def new_partial
      fetch_collections
      @opn_tb_exam = OpnTbExam.new
      #@opn_tb_exam.opn_tb_exam_values.build
      @opn_tb = OpnTb.find( OpnTbGrade.find_by( grade_id: ClassroomsGrade.find_by( classroom_id: current_user_classroom ).grade_id, year: current_user_school_year, avaliation: @avaliation, final: @final  ).opn_tb_id )        
      @opn_tb_items = OpnTbItem.where( opn_tb_id: @opn_tb.id  ).order( :order )
  
      @opn_tb_items_hash = {}
  
      @opn_tb_items.each do |x|
        @opn_tb_items_hash[OpnTbQuestion.find_by( id: x.opn_tb_question_id ).description] = x.id
        @opn_tb_exam.opn_tb_exam_values.new
      end
  
      #@opn_tb_aswers = OpnTbAnswer.where( OpnTbAnswersGroupsAnswer.where( opn_tb_answers_group_id: @opn_tb.opn_tb_answers_group_id ).opn_tb_answer_id )
      @opn_tb_aswers = OpnTbAnswer.where( id: OpnTbAnswersGroupsAnswer.where( opn_tb_answers_group_id: @opn_tb.opn_tb_answers_group_id ).select( :opn_tb_answer_id ) )
  
      #20.times { @opn_tb_exam.opn_tb_exam_values.new }
  
      #@opn_tb_values_hash = {}    
    end

    def set_opn_tb_exam
      @opn_tb_exam = OpnTbExam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_exam_params
      params.require(:opn_tb_exam).permit(:classroom_id, :student_id, :opn_tb_id, :recorded_at, :step_number, opn_tb_exam_values_attributes: [ :id, :opn_tb_exam_id, :opn_tb_item_id, :opn_tb_answer_id ] )
    end

    def school_calendar_steps
      @school_calendar_steps ||= SchoolCalendarStep.where(school_calendar: current_school_calendar).includes(:school_calendar)
    end
    helper_method :school_calendar_steps    

    def school_calendar_steps_ordered
      school_calendar_steps.ordered
    end
    helper_method :school_calendar_steps_ordered    

    def opn_tbs_list
      @opn_tbs ||= OpnTb.all
    end
    helper_method :opn_tbs_list    
  end

def fetch_collections      
  fetch_students  
end

def steps_fetcher
@steps_fetcher ||= StepsFetcher.new(current_user_classroom)
end

def fetch_students

step_id = (params[:filter] || []).delete(:by_step)   
step = steps_fetcher.step_by_id(params[:step_id])

#puts step_id 
#puts step
#student_enrollments = student_enrollments(step.start_at, step.end_at)

@students = []


  #@student_enrollments ||= student_enrollments( step.start_at, step.end_at)
  #@student_enrollments ||= student_enrollments()

  #@student_enrollments_ids = StudentEnrollmentClassroom.where( classroom_id: current_user_classroom )
  #@student_enrollments = StudentEnrollment.where( id: @student_enrollments_ids )
  @student_enrollments = StudentEnrollment.joins(:student_enrollment_classrooms).where(student_enrollment_classrooms: { classroom_code: Classroom.find(current_user_classroom).api_code }).where(student_enrollments: { active: true } )
  #@student_enrollments = StudentEnrollment.joins(:student_enrollment_classrooms).where(student_enrollment_classrooms: { classroom_id: current_user_classroom }).where.not(student_enrollments: { status: 3 } )

    # @student_enrollments.find { |enrollment| enrollment[:student_id] = @opn_tb_exam.student_id }.blank?
    #@student_enrollments << StudentEnrollment.by_student(@opn_tb_exam.student_id).first


  #@student_ids = @student_enrollments.collect(&:student_id)
  @student_ids = @student_enrollments.collect(&:student_id)

  @students = Student.where(id: @student_ids)
  #@print = @student_enrollments.map { |i| "Random text #{i}" }

end

def student_enrollments(start_at, end_at)
StudentEnrollmentsList.new(
  classroom: current_user_classroom,
  discipline: current_user_discipline,
    start_at: start_at,
    end_at: end_at,
    score_type: StudentEnrollmentScoreTypeFilters::CONCEPT,
  search_type: :by_date_range,
  period: @period
).student_enrollments
end

def find_step_id
  steps_fetcher.step(@opn_tb_exam.step_number).try(:id)
end
