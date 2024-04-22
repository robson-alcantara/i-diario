class OpnTbGradationLevelsController < ApplicationController
  before_action :set_opn_tb_gradation_level, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_gradation_levels
  # GET /opn_tb_gradation_levels.json
  def index
    @opn_tb_gradation_levels = OpnTbGradationLevel.all
  end

  # GET /opn_tb_gradation_levels/1
  # GET /opn_tb_gradation_levels/1.json
  def show
  end

  # GET /opn_tb_gradation_levels/new
  def new
    @opn_tb_gradation_level = OpnTbGradationLevel.new
  end

  # GET /opn_tb_gradation_levels/1/edit
  def edit
  end

  # POST /opn_tb_gradation_levels
  # POST /opn_tb_gradation_levels.json
  def create
    @opn_tb_gradation_level = OpnTbGradationLevel.new(opn_tb_gradation_level_params)

    respond_to do |format|
      if @opn_tb_gradation_level.save
        format.html { redirect_to @opn_tb_gradation_level, notice: 'Opn tb gradation level was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_gradation_level }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_gradation_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_gradation_levels/1
  # PATCH/PUT /opn_tb_gradation_levels/1.json
  def update
    respond_to do |format|
      if @opn_tb_gradation_level.update(opn_tb_gradation_level_params)
        format.html { redirect_to @opn_tb_gradation_level, notice: 'Opn tb gradation level was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_gradation_level }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_gradation_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_gradation_levels/1
  # DELETE /opn_tb_gradation_levels/1.json
  def destroy
    @opn_tb_gradation_level.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_gradation_levels_url, notice: 'Opn tb gradation level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_gradation_level
      @opn_tb_gradation_level = OpnTbGradationLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_gradation_level_params
      params.require(:opn_tb_gradation_level).permit(:initials, :description)
    end
end
