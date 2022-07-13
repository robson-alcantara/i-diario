class OpnTbFieldExperiencesController < ApplicationController
  before_action :set_opn_tb_field_experience, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_field_experiences
  # GET /opn_tb_field_experiences.json
  def index
    @opn_tb_field_experiences = OpnTbFieldExperience.all
  end

  # GET /opn_tb_field_experiences/1
  # GET /opn_tb_field_experiences/1.json
  def show
  end

  # GET /opn_tb_field_experiences/new
  def new
    @opn_tb_field_experience = OpnTbFieldExperience.new
  end

  # GET /opn_tb_field_experiences/1/edit
  def edit
  end

  # POST /opn_tb_field_experiences
  # POST /opn_tb_field_experiences.json
  def create
    @opn_tb_field_experience = OpnTbFieldExperience.new(opn_tb_field_experience_params)

    respond_to do |format|
      if @opn_tb_field_experience.save
        format.html { redirect_to @opn_tb_field_experience, notice: 'Opn tb field experience was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_field_experience }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_field_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_field_experiences/1
  # PATCH/PUT /opn_tb_field_experiences/1.json
  def update
    respond_to do |format|
      if @opn_tb_field_experience.update(opn_tb_field_experience_params)
        format.html { redirect_to @opn_tb_field_experience, notice: 'Opn tb field experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_field_experience }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_field_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_field_experiences/1
  # DELETE /opn_tb_field_experiences/1.json
  def destroy
    @opn_tb_field_experience.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_field_experiences_url, notice: 'Opn tb field experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_field_experience
      @opn_tb_field_experience = OpnTbFieldExperience.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_field_experience_params
      params.require(:opn_tb_field_experience).permit(:description)
    end
end
