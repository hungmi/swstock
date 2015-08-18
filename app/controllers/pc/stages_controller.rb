class Pc::StagesController < PcController

  def import
    Stage.import_sourcing(params[:file])
    redirect_to root_url
    flash[:success] = '已成功載入所有項目'
  end

  def index
    @stages = Stage.order(:order_date).paginated(params[:page])
  end

  def new
    @stage = Stage.new
    @submit_text = "新增"
  end

end