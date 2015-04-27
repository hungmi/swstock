class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  helper_method :emphasizePicnum, :emphasizeCustomer
  layout :resolve_layout

  def emphasizeCustomer(item,customerList)
    set_color
    queries = customerList.keys
    colorInds = customerList.values
    queries.each_with_index do |query,queryInd|
      styleCustomer = '<span style="color:' + @colors[colorInds[queryInd]] + ';font-size:30px;">\1</span>'
      item.item_type = view_context.highlight(item.item_type,query,highlighter: styleCustomer)
    end
    return item.item_type.html_safe
  end

  def emphasizePicnum(item,queries)
    set_color
    item.picnum = view_context.highlight(item.picnum,queries)
    item.picnum = highlight(item,getUniqPicnum(queries))
    item.picnum ? item.picnum.gsub(' +', '<br>').html_safe : item.picnum
    #item.picnum.html_safe
  end

  def highlight(item,targets)
    if targets.present? then
      @picnum = item.picnum
      targets.each_with_index do |target,targetInd|
        stylePicnum = '<span style="color:' + @colors[targetInd] + ';font-size:30px;">\1</span>'
        @picnum = view_context.highlight(@picnum ,target ,highlighter: stylePicnum)
      end
=begin
      targets.each_with_index do |target,targetInd|
        @index = picnum.index('<mark>')

        if @index then
          @index = @index - picnum.size

          if picnum[@index - 4] then

            if picnum.include? target and target.present? then
              stylePicnum = '<span id = "' + target + '" style="color:' + @colors[targetInd] + ';font-size:30px;">\1</span>'
              @picnum = view_context.highlight(picnum,target, highlighter: stylePicnum)
              #return picnum.include? target
            end

          end # if picnum[@index - 4] then

        end # if @index then end

      end # targets.each_with_index
=end

    !@picnum.blank? ? @picnum : item.picnum

    end  # if targets.present? then

  end
  
  #為了取得可能的四碼，也就是9475及7945，
  def getUniqPicnum(queries)
    @targets = []
    queries.each do |query|
      #首先為了避免比對太多，要先取出搜尋後的結果
      @items = Item.search(query).all
      #picnums用來裝regex過濾出的純數字圖號
      picnums = []
      #targets則用來裝9475及7945
=begin
      #防止search query不是字串
      string = string.to_s
=end

      #開始逐個過濾出純數字圖號
      @items.each do |item|
        picnums << item.picnum.scan(/[\d]{8,}/).flatten
        #本來item.picnum是拉桿123+活塞456(90長)的話
        #輸出的picnums會像[["123","456"]]
        #下一個item.picnum是拉桿789的話
        #輸出的picnums就變[["123","456"],["789"]]
        #所以底下會需要兩層迴圈，避免同一欄有多圖號
      end
      picnums.each do |p|
          p.each do |x|
              #先確定有沒有找到要找的，例如"11520"
              strInd = x.index(query)
              if strInd and !x[ strInd-4 .. strInd-1 ].blank? then
                @targets << x[ strInd-4 .. strInd-1 ] #取得找到的位置的前四碼
              elsif strInd then
                @targets << x[ 0 .. strInd-1 ] #取得找到的位置之前所有號碼
              end
              #依序塞進targets裡，最後targets會像["9475","7945","7945"]
          end
      end
    end
    return @targets.uniq.select(&:present?)
    #把重複的篩選掉，最後targets會像["9475","7945"]
  end

  # GET /items
  # GET /items.json
  def index
    if params[:search]
      params[:search] = params[:search].strip.split(/\s+/)
      @items = Item.all
      @itemsSearchUnion = Item.none
      @itemsSearchIntersection = Item.all
      params[:search].each do |query|
        @itemsSearchUnion = @itemsSearchUnion + @items.search(query).all
        @itemsSearchIntersection = @itemsSearchIntersection.search(query).all
      end
      @items = (@itemsSearchUnion | @itemsSearchIntersection).sort_by{ |i| i[:item_type] } #Union of queries
    else
      @items = Item.all
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @submitText = "Create"
  end

  # GET /items/1/edit
  def edit
    @submitText = "Update"
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: 'Item was successfully created.' }
        format.json { render :index, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_path, notice: 'Item was successfully updated.' }
        format.json { render :index, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.' 
  end

  private
    def set_color
      @colors = ['black','royalblue','darkviolet','darkorange','slatgray','saddlebrown','goldenrod','cyan','limegreen','red']
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:location, :item_type, :picnum, :amount)
    end

    def resolve_layout
      case action_name
      when "index"
        "noBodyContainer"
      else
        "application"
      end
    end

end
