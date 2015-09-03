class StagesController < PcController
  before_action :set_stage, only: [:show, :edit, :update, :destroy]

  def index
    @stages = Stage.all
  end

  def show
  end

  def new
    @stage = Stage.new
  end

  def edit
  end

  def create
    @stage = Stage.new(stage_params)

    respond_to do |format|
      if @stage.save
        format.html { redirect_to procedures_path, notice: 'Stage was successfully created.' }
        format.json { render :show, status: :created, location: @stage }
      else
        format.html { render :new }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stage.update(stage_params)
        format.html { redirect_to procedures_path, notice: 'Stage was successfully updated.' }
        #format.json { render :show, status: :ok, location: @stage }
      else
        format.html { redirect_to procedures_path }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stage.destroy
    respond_to do |format|
      format.html { redirect_to stages_url, notice: 'Stage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stage
      @stage = Stage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stage_params
      params.require(:stage).permit(:arrival_date, :amount, :factory_name, :estimated_date, :finish_date, :note, :finished, :broken)
    end
end
