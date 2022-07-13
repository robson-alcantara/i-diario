class OpnTbAnswersGroupsController < ApplicationController
  before_action :set_opn_tb_answers_group, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_answers_groups
  # GET /opn_tb_answers_groups.json
  def index
    @opn_tb_answers_groups = OpnTbAnswersGroup.all
  end

  # GET /opn_tb_answers_groups/1
  # GET /opn_tb_answers_groups/1.json
  def show
  end

  # GET /opn_tb_answers_groups/new
  def new
    @opn_tb_answers_group = OpnTbAnswersGroup.new
  end

  # GET /opn_tb_answers_groups/1/edit
  def edit
  end

  # POST /opn_tb_answers_groups
  # POST /opn_tb_answers_groups.json
  def create
    @opn_tb_answers_group = OpnTbAnswersGroup.new(opn_tb_answers_group_params)

    respond_to do |format|
      if @opn_tb_answers_group.save
        format.html { redirect_to @opn_tb_answers_group, notice: 'Opn tb answers group was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_answers_group }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_answers_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_answers_groups/1
  # PATCH/PUT /opn_tb_answers_groups/1.json
  def update
    respond_to do |format|
      if @opn_tb_answers_group.update(opn_tb_answers_group_params)
        format.html { redirect_to @opn_tb_answers_group, notice: 'Opn tb answers group was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_answers_group }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_answers_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_answers_groups/1
  # DELETE /opn_tb_answers_groups/1.json
  def destroy
    @opn_tb_answers_group.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_answers_groups_url, notice: 'Opn tb answers group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_answers_group
      @opn_tb_answers_group = OpnTbAnswersGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_answers_group_params
      params.require(:opn_tb_answers_group).permit(:name)
    end
end
