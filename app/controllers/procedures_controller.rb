class ProceduresController < PcController
  layout 'pc/procedures'
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]
  
  def import
    Procedure.import_sourcing(params[:file])
    Procedure.run_first_stage
    redirect_to procedures_path
    flash[:success] = '已成功載入所有項目'
  end
  # GET /pc/procedures
  # GET /pc/procedures.json
  def index
    @procedures = Procedure.all#.joins(:stages).where( :stages => { finish_date: nil } ).all
  end

  # GET /pc/procedures/1
  # GET /pc/procedures/1.json
  def show
  end

  # GET /pc/procedures/new
  def new
    @procedure = if params[:copy_id]
      @copy_procedure = Procedure.find(params[:copy_id])
      @copy_procedure.fork
    else
      Procedure.new
    end
  end

  # GET /pc/procedures/1/edit
  def edit
  end

  # POST /pc/procedures
  # POST /pc/procedures.json
  def create
    @procedure = Procedure.new(procedure_params)
    @procedure.stages.each do |stage|
      stage.arrival_amount = @procedure.procedure_amount
    end
    respond_to do |format|
      if @procedure.save
        format.html { redirect_to procedures_path, notice: 'Procedure was successfully created.' }
        format.json { render :show, status: :created, location: @procedure }
      else
        format.html { render :new }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pc/procedures/1
  # PATCH/PUT /pc/procedures/1.json
  def update
    respond_to do |format|
      if @procedure.update(procedure_params)
        format.html { redirect_to procedures_path, notice: 'Procedure was successfully updated.' }
        format.json { render :show, status: :ok, location: @procedure }
      else
        format.html { redirect_to procedures_path }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pc/procedures/1
  # DELETE /pc/procedures/1.json
  def destroy
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedures_url, notice: 'Procedure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedure_params
      params.require(:procedure).permit(:sourcing_type, :start_date, :customer, :material_spec, :procedure_amount, :workpiece_id, stages_attributes: [:id, :factory_name, :note, :arrival_date, :amount, :estimated_date, :finish_date, :finished, :broken, :procedure_id, :_destroy])
    end
end
