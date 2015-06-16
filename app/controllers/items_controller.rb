class ItemsController < ApplicationController
  
  include StockTableInitializer
  
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :previous_page, only: [:newest, :index, :edit]
  before_action :validate_search_key, only: [:search]


  def previous_page
    session[:last_page] = request.env['HTTP_REFERER']
  end

  def search
    @items = Item.ransack(validate_search_key).result if params[:q].present?
  end

  def import
    invalid_product_num = Item.import(params[:file])
    redirect_to root_url
    return flash[:success] = '已成功載入所有項目' if invalid_product_num == 0
    flash[:warning] = "#{ invalid_product_num }個項目的櫃位或圖號不完整"    
  end

  def export
    @items_export = Item.order(:location)
    respond_to do |format|
      #format.csv { send_data @items_export.export }
      format.xls { send_data @items_export.export(col_sep: "\t") }
      format.xlsx { send_data @items_export.export(col_sep: "\t") }
    end
  end

  def newest
    @items = Item.recent.limit(5) #limit will return ActiveRecord_Relation
  end

  # GET /items
  # GET /items.json
  def index
    @items = Item.order(:location).paginated(params[:page])
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @submit_text = "新增"
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
      if @item.save
        flash[:success] = "項目已新增!"
        redirect_to root_url
      else
        flash[:danger] = "新增失敗!"
        @submit_text = "新增"
        render 'new'
      end
  end

  # GET /items/1/edit
  def edit
    @submit_text = "更新"
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if @item.update(item_params)
      flash[:success] = "資料更新成功!"
      redirect_to session[:last_page]  # ajax
    else
      flash[:danger] = "資料更新失敗!"
      render 'edit'
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    flash[:success] = "項目已刪除!"
    redirect_to session[:last_page]
  end

  def destroy_all_page; end

  def destroy_all
    Item.destroy_all
    flash[:success] = 'There are no items now.'
    redirect_to root_url
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def validate_search_key
      # params[:q].class => string
      # Items_helper need @query_array
      @query_array = params[:q].gsub(/\\|\'|\/|\?/, "").strip.split(/\s+/) if params[:q].present?
      search_criteria(@query_array) if @query_array.present? # !!!
    end

    def search_criteria(query_string)
      { :location_or_item_type_or_picnum_or_oldpicnum_or_note_or_finished_or_unfinished_or_customer_cont_any => query_string }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:location, :item_type, :picnum, :oldpicnum, :note, :finished, :unfinished, :customer)
    end
    

end
