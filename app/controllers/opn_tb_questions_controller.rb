class OpnTbQuestionsController < ApplicationController
  before_action :set_opn_tb_question, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_questions
  # GET /opn_tb_questions.json
  def index
    @opn_tb_questions = OpnTbQuestion.all
  end

  # GET /opn_tb_questions/1
  # GET /opn_tb_questions/1.json
  def show
  end

  # GET /opn_tb_questions/new
  def new
    @opn_tb_question = OpnTbQuestion.new
  end

  # GET /opn_tb_questions/1/edit
  def edit
  end

  # POST /opn_tb_questions
  # POST /opn_tb_questions.json
  def create
    @opn_tb_question = OpnTbQuestion.new(opn_tb_question_params)

    respond_to do |format|
      if @opn_tb_question.save
        format.html { redirect_to @opn_tb_question, notice: 'Opn tb question was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_question }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_questions/1
  # PATCH/PUT /opn_tb_questions/1.json
  def update
    respond_to do |format|
      if @opn_tb_question.update(opn_tb_question_params)
        format.html { redirect_to @opn_tb_question, notice: 'Opn tb question was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_question }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_questions/1
  # DELETE /opn_tb_questions/1.json
  def destroy
    @opn_tb_question.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_questions_url, notice: 'Opn tb question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_question
      @opn_tb_question = OpnTbQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_question_params
      params.require(:opn_tb_question).permit(:description, :discipline_id)
    end
end
