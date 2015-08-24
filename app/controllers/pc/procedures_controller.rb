class Pc::ProceduresController < PcController
  layout 'pc/procedures'
  before_action :set_pc_procedure, only: [:show, :edit, :update, :destroy]

  # GET /pc/procedures
  # GET /pc/procedures.json
  def index
    @pc_procedures = Pc::Procedure.all
  end

  # GET /pc/procedures/1
  # GET /pc/procedures/1.json
  def show
  end

  # GET /pc/procedures/new
  def new
    if params[:copy_id]
      @pc_procedure = Pc::Procedure.new(Pc::Procedure.find(params[:copy_id]).attributes)
      @stages = Pc::Stage.where(@pc_procedure.id)
      @pc_procedure.id = nil
    else
      @pc_procedure = Pc::Procedure.new
    end
  end

  # GET /pc/procedures/1/edit
  def edit
  end

  # POST /pc/procedures
  # POST /pc/procedures.json
  def create
    @pc_procedure = Pc::Procedure.new(Pc::Procedure.find(params[:copy_id]).attributes)
    @pc_procedure.id = nil

    respond_to do |format|
      if @pc_procedure.save
        format.html { redirect_to @pc_procedure, notice: 'Procedure was successfully created.' }
        format.json { render :show, status: :created, location: @pc_procedure }
      else
        format.html { render :new }
        format.json { render json: @pc_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pc/procedures/1
  # PATCH/PUT /pc/procedures/1.json
  def update
    respond_to do |format|
      if @pc_procedure.update(pc_procedure_params)
        format.html { redirect_to @pc_procedure, notice: 'Procedure was successfully updated.' }
        format.json { render :show, status: :ok, location: @pc_procedure }
      else
        format.html { render :edit }
        format.json { render json: @pc_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pc/procedures/1
  # DELETE /pc/procedures/1.json
  def destroy
    @pc_procedure.destroy
    respond_to do |format|
      format.html { redirect_to pc_procedures_url, notice: 'Procedure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pc_procedure
      @pc_procedure = Pc::Procedure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def copied_procedure_params
      params.require(:copied_procedure).permit(:material_spec, :customer, :workpiece_id)
    end

    def pc_procedure_params
      params.require(:pc_procedure).permit(:sourcing_type, :start_date, :customer, :material_spec, :amount, :workpiece_id)
    end
end
