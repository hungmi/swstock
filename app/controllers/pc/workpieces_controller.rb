class Pc::WorkpiecesController < PcController
  before_action :set_pc_workpiece, only: [:show, :edit, :update, :destroy]

  def import
    Pc::Workpiece.import_sourcing(params[:file])
    redirect_to pc_workpieces_path
    flash[:success] = '已成功載入所有項目'
  end
  # GET /pc/workpieces
  # GET /pc/workpieces.json
  def index
    @pc_workpieces = Pc::Workpiece.all
  end

  # GET /pc/workpieces/1
  # GET /pc/workpieces/1.json
  def show
  end

  # GET /pc/workpieces/new
  def new
    @pc_workpiece = Pc::Workpiece.new
  end

  # GET /pc/workpieces/1/edit
  def edit
  end

  # POST /pc/workpieces
  # POST /pc/workpieces.json
  def create
    @pc_workpiece = Pc::Workpiece.new(pc_workpiece_params)

    respond_to do |format|
      if @pc_workpiece.save
        format.html { redirect_to @pc_workpiece, notice: 'Workpiece was successfully created.' }
        format.json { render :show, status: :created, location: @pc_workpiece }
      else
        format.html { render :new }
        format.json { render json: @pc_workpiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pc/workpieces/1
  # PATCH/PUT /pc/workpieces/1.json
  def update
    respond_to do |format|
      if @pc_workpiece.update(pc_workpiece_params)
        format.html { redirect_to @pc_workpiece, notice: 'Workpiece was successfully updated.' }
        format.json { render :show, status: :ok, location: @pc_workpiece }
      else
        format.html { render :edit }
        format.json { render json: @pc_workpiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pc/workpieces/1
  # DELETE /pc/workpieces/1.json
  def destroy
    @pc_workpiece.destroy
    respond_to do |format|
      format.html { redirect_to pc_workpieces_url, notice: 'Workpiece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pc_workpiece
      @pc_workpiece = Pc::Workpiece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pc_workpiece_params
      params[:pc_workpiece]
    end
end
