class Pc::ItemsController < ItemsController
  layout 'pc/application'
  
  def search
    @orginal_items = Item.ransack(validate_search_key).result if params[:q].present?
    @items = Item.ransack(validate_search_key).result if params[:q].present?
    render :index
  end

  def index
    @orginal_items = Item.order(:location)
    @items = Item.order(:location).paginated(params[:page])
  end 

end