class OpnTbGradesController < ApplicationController
  before_action :set_opn_tb_grade, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_grades
  # GET /opn_tb_grades.json
  def index
    @opn_tb_grades = OpnTbGrade.all
  end

  # GET /opn_tb_grades/1
  # GET /opn_tb_grades/1.json
  def show
  end

  # GET /opn_tb_grades/new
  def new
    @opn_tb_grade = OpnTbGrade.new
  end

  # GET /opn_tb_grades/1/edit
  def edit
  end

  # POST /opn_tb_grades
  # POST /opn_tb_grades.json
  def create
    @opn_tb_grade = OpnTbGrade.new(opn_tb_grade_params)

    respond_to do |format|
      if @opn_tb_grade.save
        format.html { redirect_to @opn_tb_grade, notice: 'Opn tb grade was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_grade }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_grades/1
  # PATCH/PUT /opn_tb_grades/1.json
  def update
    respond_to do |format|
      if @opn_tb_grade.update(opn_tb_grade_params)
        format.html { redirect_to @opn_tb_grade, notice: 'Opn tb grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_grade }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_grades/1
  # DELETE /opn_tb_grades/1.json
  def destroy
    @opn_tb_grade.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_grades_url, notice: 'Opn tb grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_grade
      @opn_tb_grade = OpnTbGrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_grade_params
      params.require(:opn_tb_grade).permit(:opn_tb_id, :grade_id, :year, :avaliation, :final)
    end
end
