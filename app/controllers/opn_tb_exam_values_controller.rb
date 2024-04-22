class OpnTbExamValuesController < ApplicationController
  before_action :set_opn_tb_exam_value, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_exam_values
  # GET /opn_tb_exam_values.json
  def index
    @opn_tb_exam_values = OpnTbExamValue.all
  end

  # GET /opn_tb_exam_values/1
  # GET /opn_tb_exam_values/1.json
  def show
  end

  # GET /opn_tb_exam_values/new
  def new
    @opn_tb_exam = OpnTbExam.find(params[:opn_tb_exam_id])
    @opn_tb_items = OpnTbItem.where( opn_tb_id: @opn_tb_exam.opn_tb_id )

    @hash = {}

    @opn_tb_items.each do |x|
      @hash[OpnTbQuestion.find_by( id: x.opn_tb_question_id ).description] = x.id
    end

    @opn_tb_exam_value = OpnTbExamValue.new
  end

  # GET /opn_tb_exam_values/1/edit
  def edit
  end

  # POST /opn_tb_exam_values
  # POST /opn_tb_exam_values.json
  def create
    @opn_tb_exam_value = OpnTbExamValue.new(opn_tb_exam_value_params)

    respond_to do |format|
      if @opn_tb_exam_value.save
        format.html { redirect_to @opn_tb_exam_value, notice: 'Opn tb exam value was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_exam_value }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_exam_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_exam_values/1
  # PATCH/PUT /opn_tb_exam_values/1.json
  def update
    respond_to do |format|
      if @opn_tb_exam_value.update(opn_tb_exam_value_params)
        format.html { redirect_to @opn_tb_exam_value, notice: 'Opn tb exam value was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_exam_value }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_exam_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_exam_values/1
  # DELETE /opn_tb_exam_values/1.json
  def destroy
    @opn_tb_exam_value.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_exam_values_url, notice: 'Opn tb exam value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_exam_value
      @opn_tb_exam_value = OpnTbExamValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_exam_value_params
      params.require(:opn_tb_exam_value).permit(:opn_tb_exam_id, :opn_tb_item_id, :opn_tb_answer_id)
    end
end
