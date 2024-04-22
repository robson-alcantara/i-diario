class OpnTbsController < ApplicationController
  before_action :set_opn_tb, only: [:show, :edit, :update, :destroy]

  # GET /opn_tbs
  # GET /opn_tbs.json
  def index
    @opn_tbs = OpnTb.all
  end

  # GET /opn_tbs/1
  # GET /opn_tbs/1.json
  def show
  end

  # GET /opn_tbs/new
  def new
    @opn_tb = OpnTb.new
  end

  # GET /opn_tbs/1/edit
  def edit
  end

  # POST /opn_tbs
  # POST /opn_tbs.json
  def create
    @opn_tb = OpnTb.new(opn_tb_params)

    respond_to do |format|
      if @opn_tb.save
        format.html { redirect_to @opn_tb, notice: 'Opn tb was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb }
      else
        format.html { render :new }
        format.json { render json: @opn_tb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tbs/1
  # PATCH/PUT /opn_tbs/1.json
  def update
    respond_to do |format|
      if @opn_tb.update(opn_tb_params)
        format.html { redirect_to @opn_tb, notice: 'Opn tb was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tbs/1
  # DELETE /opn_tbs/1.json
  def destroy
    @opn_tb.destroy
    respond_to do |format|
      format.html { redirect_to opn_tbs_url, notice: 'Opn tb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb
      @opn_tb = OpnTb.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_params
      params.require(:opn_tb).permit(:description, :opn_tb_answers_group_id)
    end
end
