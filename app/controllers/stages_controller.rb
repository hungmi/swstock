class StagesController < PcController
  before_action :set_stage, only: [:show, :edit, :update, :destroy, :finish, :arrive]

  def index
    @stages = Stage.all
  end

  def show
  end

  def new
    @stage = Stage.new
  end

  def edit
    respond_to do |format|
      @procedure = Procedure.find(params[:procedure_id])
      @stage = @procedure.stages.find(params[:id]) if @procedure
      @picnum = @procedure.workpiece.picnum    
      format.js {}
    end
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
        if @stage.may_finish?
          @stage.finish!
          @stage.next.run! if @stage.next
          format.js { render 'stages/finish.js.erb' }
        else
          format.js {}
        end
      else
        format.js { render :json => { :error => @stage.errors.full_messages }, :status => 422 }
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

  # def finish
  #   respond_to do |format|
  #     if @stage.finished_amount.present?
  #       @stage.finish! if @stage.may_finish?
  #       @stage.next.try(:run!) if @stage.next.try(:may_run?)
  #       format.js {}
  #     end
  #   end
  # end

  def arrive
    @stage.update(arrival_date: Date.today.to_s)
    redirect_to procedures_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stage
      @stage = Stage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stage_params
      params.require(:stage).permit(:arrival_date, :arrival_amount, :factory_name, :estimated_date, :finished_date, :note, :finished_amount, :broken_amount)
    end
end
