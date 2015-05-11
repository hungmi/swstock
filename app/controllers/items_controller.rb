class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :updateViaForm]
  helper_method :emphasizePicnum, :emphasizeCustomer, :textAreaRowNum, :formatPicnum
  layout :resolve_layout

  def formatPicnum(picnum)
    styles = '<br><span style="margin-right:3em; font-size: 26px; color:red;">+</span><br>'
    editedPicnum = picnum.gsub('+', styles).html_safe
  end

  def textAreaRowNum(text)
    rowNum = 0
    text = text.gsub(/\n$/,'')

    text.each_line do |line|
      line.length > 20 ? rowNum += 1 + (line.length/20) : rowNum += 1
    end
    return rowNum
  end

  def emphasizeCustomer(item_type,customerList)
    set_color
    queries = customerList.keys #從view那邊定義好顧客清單，key為顧客名稱
    colorInds = customerList.values #value為顧客對應的顏色號碼
    queries.each_with_index do |query,queryInd|
      styleCustomer = '<span style="color:' + @colors[colorInds[queryInd]] + ';font-size:30px;">\1</span>'
      item_type = view_context.highlight(item_type,query,highlighter: styleCustomer)
    end
    return item_type.html_safe
  end

  def emphasizePicnum(picnum,queries)
    set_color #取得顏色array
    highlightedPicnum = view_context.highlight(picnum,queries) #使用內建highlight標注出搜尋字串
    editedPicnum = customizedHighlight(highlightedPicnum,getUniqPicnum(queries))
    editedPicnum ? formatPicnum(editedPicnum) : formatPicnum(highlightedPicnum)
    #item.picnum.html_safe
  end

  def customizedHighlight(picnum,targets)
    if targets.present? then
      @picnum = picnum
      targets.each_with_index do |target,targetInd|
        stylePicnum = '<span style="color:' + @colors[targetInd] + ';font-size:30px;">\1</span>'
        @picnum = view_context.highlight(@picnum ,target ,highlighter: stylePicnum)
      end

    !@picnum.blank? ? @picnum : picnum

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

      #開始逐個過濾出純數字圖號
      @items.each do |item|
        picnums << item.picnum.scan(/[\d]{8,}/).flatten if item.picnum.present?
        picnums << item.oldPicnum.scan(/[\d]{8,}/).flatten if item.oldPicnum.present?
      end
      #本來item.picnum是拉桿123+活塞456(90長)的話
      #輸出的picnums會像[["123","456"]]
      #下一個item.picnum是拉桿789的話
      #輸出的picnums就變[["123","456"],["789"]]
      #所以底下會需要兩層迴圈，避免同一欄有多圖號
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

  def import
    Item.import(params[:file])
    redirect_to root_url, notice: "Items imported."
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
      @items = (@itemsSearchUnion | @itemsSearchIntersection).sort_by{ |i| i[:location] } #Union of queries
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
    @submitText = "新增"
  end

  # GET /items/1/edit
  def edit
    @submitText = "更新"
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
      if @item.save
        flash[:success] = '項目已新增!'
        redirect_to items_path
      else
        flash[:danger] = '新增失敗!'
        @submitText = "新增"
        render 'new'
      end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if @item.update(item_params)
      flash[:success] = '資料更新成功!'
      redirect_to :back
    else
      flash[:danger] = '資料更新失敗!'
      redirect_to :back
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    flash[:success] = '項目已刪除!'
    redirect_to items_url
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
      params.require(:item).permit(:location, :item_type, :picnum, :oldPicnum, :note, :finishQty, :unfinishQty)
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
