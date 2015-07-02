class Pc::ItemsController < ItemsController
  layout 'pc/application'

  def set_table_titles
    # items/partial/_stock_table.html.erb need @table_titles
    @table_titles = { '櫃位' => 'xs', '圖號'=>'lg', '' => 'xs', '舊圖號'=>'lg', '提醒'=>'lg', '成品'=>'sm', '半成品'=>'sm', '剪貼板' => 'lg' }
  end

  def search
    @orginal_items = Item.ransack(validate_search_key).result if params[:q].present?
    @items = Item.ransack(validate_search_key).result if params[:q].present?
  end

  def index
    @orginal_items = Item.order(:location)
    @items = Item.order(:location).paginated(params[:page])
  end

end