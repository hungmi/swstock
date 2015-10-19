class WorkpiecesController < PcController
  #layout 'pc/procedures'

  before_action :set_workpiece, only: [:show, :edit, :update, :destroy]

  # GET /pc/workpieces
  # GET /pc/workpieces.json
  def index
    @workpieces = Workpiece.all
  end

  # GET /pc/workpieces/1
  # GET /pc/workpieces/1.json
  def show
  end

  # GET /pc/workpieces/new
  def new
    @workpiece = Workpiece.new
  end

  # GET /pc/workpieces/1/edit
  def edit
  end

  # POST /pc/workpieces
  # POST /pc/workpieces.json
  def create
    @workpiece = Workpiece.new(workpiece_params)

    respond_to do |format|
      if @workpiece.save
        format.html { redirect_to @workpiece, notice: 'Workpiece was successfully created.' }
        format.json { render :show, status: :created, location: @workpiece }
      else
        format.html { render :new }
        format.json { render json: @workpiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pc/workpieces/1
  # PATCH/PUT /pc/workpieces/1.json
  def update
    respond_to do |format|
      if @workpiece.update(workpiece_params)
        format.html { redirect_to @workpiece, notice: 'Workpiece was successfully updated.' }
        format.json { render :show, status: :ok, location: @workpiece }
      else
        format.html { render :edit }
        format.json { render json: @workpiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pc/workpieces/1
  # DELETE /pc/workpieces/1.json
  def destroy
    @workpiece.destroy
    respond_to do |format|
      format.html { redirect_to workpieces_url, notice: 'Workpiece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workpiece
      @workpiece = Workpiece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workpiece_params
      params.require(:workpiece).permit(:wp_type, :picnum, :spec)
    end
end
