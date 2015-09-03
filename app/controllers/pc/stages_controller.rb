class Pc::StagesController < PcController
  before_action :set_pc_stage, only: [:show, :edit, :update, :destroy]

  # GET /pc/stages
  # GET /pc/stages.json
  def index
    @pc_stages = Pc::Stage.all
  end

  # GET /pc/stages/1
  # GET /pc/stages/1.json
  def show
  end

  # GET /pc/stages/new
  def new
    @pc_stage = Pc::Stage.new
  end

  # GET /pc/stages/1/edit
  def edit
  end

  # POST /pc/stages
  # POST /pc/stages.json
  def create
    @pc_stage = Pc::Stage.new(pc_stage_params)

    respond_to do |format|
      if @pc_stage.save
        format.html { redirect_to @pc_stage, notice: 'Stage was successfully created.' }
        format.json { render :show, status: :created, location: @pc_stage }
      else
        format.html { render :new }
        format.json { render json: @pc_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pc/stages/1
  # PATCH/PUT /pc/stages/1.json
  def update
    respond_to do |format|
      if @pc_stage.update(pc_stage_params)
        format.html { redirect_to @pc_stage, notice: 'Stage was successfully updated.' }
        format.json { render :show, status: :ok, location: @pc_stage }
      else
        format.html { render :edit }
        format.json { render json: @pc_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pc/stages/1
  # DELETE /pc/stages/1.json
  def destroy
    @pc_stage.destroy
    respond_to do |format|
      format.html { redirect_to pc_stages_url, notice: 'Stage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pc_stage
      @pc_stage = Pc::Stage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pc_stage_params
      params.require(:pc_stage).permit(:arrival_date, :amount, :factory_name, :estimated_date, :finish_date, :note, :finished, :broken)
    end
end
