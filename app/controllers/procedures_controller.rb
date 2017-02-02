class ProceduresController < PcController
  #layout 'pc/procedures'
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]
  before_action :validate_search_key, only: [:search]
  
  def import
    Procedure.import_sourcing(params[:file])
    redirect_to procedures_path
    flash[:success] = '已成功載入所有項目'
  end
  # GET /pc/procedures
  # GET /pc/procedures.json
  def index
    @procedures = Procedure.all.order('updated_at DESC').paginated(params[:page])#.joins(:stages).where( :stages => { finish_date: nil } ).all
  end

  def search
    @workpieces = Workpiece.ransack(validate_search_key).result.includes(:procedures).order('procedures.start_date DESC') if params[:q].present?
    #@procedures = Workpiece.ransack(validate_search_key).result if params[:q].present?
    #render :index
  end

  # GET /pc/procedures/1
  # GET /pc/procedures/1.json
  def show
  end

  # GET /pc/procedures/new
  def new
    @procedure = if params[:copy_id]
      @copy_procedure = Procedure.find(params[:copy_id])
      @workpiece = @copy_procedure.workpiece
      @copy_procedure.fork
    else
      @workpiece = Workpiece.new
      @procedure = @workpiece.procedures.new
      #@procedure.stages.new
    end
  end

  # GET /pc/procedures/1/edit
  def edit
    @workpiece = @procedure.workpiece
  end

  # POST /pc/procedures
  # POST /pc/procedures.json
  def create
    @workpiece = Workpiece.where(picnum: params[:procedure][:workpiece][:picnum]).first_or_create(wp_type: params[:procedure][:workpiece][:wp_type])
    @procedure = @workpiece.procedures.new(procedure_params)
    @procedure.stages.each_with_index do |stage, i|
      stage.run! if i == 0
      stage.arrival_amount = @procedure.procedure_amount
    end
    respond_to do |format|
      if @procedure.save
        format.html { redirect_to procedures_path }
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
        format.html { redirect_to procedures_path }
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
      format.html { redirect_to procedures_path, notice: 'Procedure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    def search_criteria(query_string)
      { :picnum_or_procedures_customer_cont_any => query_string }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedure_params
      params.require(:procedure).permit(:sourcing_type, :start_date, :customer, :material_spec, :procedure_amount, :workpiece_id, :aasm_state, stages_attributes: [:id, :factory_name, :note, :arrival_date, :arrival_amount, :estimated_date, :finished_date, :finished_amount, :broken_amount, :aasm_state, :procedure_id, :_destroy])
    end
end
