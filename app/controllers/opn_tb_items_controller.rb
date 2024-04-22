class OpnTbItemsController < ApplicationController
  before_action :set_opn_tb_item, only: [:show, :edit, :update, :destroy]

  # GET /opn_tb_items
  # GET /opn_tb_items.json
  def index
    @opn_tb_items = OpnTbItem.all
  end

  # GET /opn_tb_items/1
  # GET /opn_tb_items/1.json
  def show
  end

  # GET /opn_tb_items/new
  def new
    @opn_tb_item = OpnTbItem.new
  end

  # GET /opn_tb_items/1/edit
  def edit
  end

  # POST /opn_tb_items
  # POST /opn_tb_items.json
  def create
    @opn_tb_item = OpnTbItem.new(opn_tb_item_params)

    respond_to do |format|
      if @opn_tb_item.save
        format.html { redirect_to @opn_tb_item, notice: 'Opn tb item was successfully created.' }
        format.json { render :show, status: :created, location: @opn_tb_item }
      else
        format.html { render :new }
        format.json { render json: @opn_tb_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opn_tb_items/1
  # PATCH/PUT /opn_tb_items/1.json
  def update
    respond_to do |format|
      if @opn_tb_item.update(opn_tb_item_params)
        format.html { redirect_to @opn_tb_item, notice: 'Opn tb item was successfully updated.' }
        format.json { render :show, status: :ok, location: @opn_tb_item }
      else
        format.html { render :edit }
        format.json { render json: @opn_tb_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opn_tb_items/1
  # DELETE /opn_tb_items/1.json
  def destroy
    @opn_tb_item.destroy
    respond_to do |format|
      format.html { redirect_to opn_tb_items_url, notice: 'Opn tb item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opn_tb_item
      @opn_tb_item = OpnTbItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opn_tb_item_params
      params.require(:opn_tb_item).permit(:opn_tb_id, :opn_tb_question_id, :opn_tb_gradation_level_id, :order)
    end
end
