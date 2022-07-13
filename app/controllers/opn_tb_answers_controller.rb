class OpnTbAnswersController < ApplicationController
  before_action :set_opn_tb_answer, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_answers
  # GET /opn_tb_answers.json
  def index
    @opn_tb_answers = OpnTbAnswer.all
  end

  # GET /opn_tb_answers/1
  # GET /opn_tb_answers/1.json
  def show
  end

  # GET /opn_tb_answers/new
  def new
    @opn_tb_answer = OpnTbAnswer.new
  end

  # GET /opn_tb_answers/1/edit
  def edit
  end

  # POST /opn_tb_answers
  # POST /opn_tb_answers.json
  def create
    @opn_tb_answer = OpnTbAnswer.new(opn_tb_answer_params)

    respond_to do |format|
      if @opn_tb_answer.save
        format.html { redirect_to @opn_tb_answer, notice: 'Opn tb answer was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_answer }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_answers/1
  # PATCH/PUT /opn_tb_answers/1.json
  def update
    respond_to do |format|
      if @opn_tb_answer.update(opn_tb_answer_params)
        format.html { redirect_to @opn_tb_answer, notice: 'Opn tb answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_answer }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_answers/1
  # DELETE /opn_tb_answers/1.json
  def destroy
    @opn_tb_answer.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_answers_url, notice: 'Opn tb answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_answer
      @opn_tb_answer = OpnTbAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_answer_params
      params.require(:opn_tb_answer).permit(:initials, :description)
    end
end
