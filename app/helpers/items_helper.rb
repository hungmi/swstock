module ItemsHelper

  include PicnumHelper

  def item_id_to_tag_id(item)
    "edit_item_#{item.id}"
  end

  # step 1

  def render_item_note(note)
    if note.present?
    raw("<%= f.text_area :note, :value => item.note.gsub(/\n$/,''), rows: count_row(item.note,20), id: submit_id %>")
    else
      raw("<%= f.text_area :note, rows: 1, id: submit_id %>")
    end
    
  end

  def style_customer(customer_name)
    style_customer = "background-color:#{@customer_colors[customer_name]}"
  end

end

  # step 2
=begin

  def uniq_part(picnum, queries)
    @targets = []
    # 1 find position of mark in string
    
  end

  # step 3

  def emphasize(picnum, queries)
    if targets.present?
      @picnum = picnum
      targets.each_with_index do |target,targetInd|
        stylePicnum = '<span style="color:' + @colors[targetInd] + ';font-size:30px;">\1</span>'
        @picnum = view_context.highlight(@picnum ,target ,highlighter: stylePicnum)
      end

    !@picnum.blank? ? @picnum : picnum

    end  # if targets.present? then
  end

  def customized_highlight(picnum,targets)
    if targets.present?
      @picnum = picnum
      targets.each_with_index do |target,targetInd|
        stylePicnum = '<span style="color:' + @colors[targetInd] + ';font-size:30px;">\1</span>'
        @picnum = view_context.highlight(@picnum ,target ,highlighter: stylePicnum)
      end

    !@picnum.blank? ? @picnum : picnum

    end  # if targets.present? then

  end

  #為了取得可能的四碼，也就是9475及7945，
  def get_uniq_picnum(queries)
    @targets = []
    Array(queries).each do |query|
      #首先為了避免比對太多，要先取出搜尋後的結果
      @items_for_uniq = Item.ransack(query)
      #picnums用來裝regex過濾出的純數字圖號
      picnums = []
      #targets則用來裝9475及7945

      #開始逐個過濾出純數字圖號
      @items_for_uniq.each do |item|
        picnums << item.picnum.scan(/[\d]{8,}/).flatten if item.picnum.present?
        picnums << item.oldpicnum.scan(/[\d]{8,}/).flatten if item.oldpicnum.present?
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
              if strInd and !x[ strInd-4 .. strInd-1 ].blank?
                @targets << x[ strInd-4 .. strInd-1 ] #取得找到的位置的前四碼
              elsif strInd
                @targets << x[ 0 .. strInd-1 ] #取得找到的位置之前所有號碼
              end
              #依序塞進targets裡，最後targets會像["9475","7945","7945"]
          end
      end
    end
    return @targets.uniq.select(&:present?)
    #把重複的篩選掉，最後targets會像["9475","7945"]
  end
  def emphasize_picnum(picnum,queries)
    set_color #取得顏色array
    highlighted_picnum = view_context.highlight(picnum,queries) #使用內建highlight標注出搜尋字串
    edited_picnum = customized_highlight(highlighted_picnum,get_uniq_picnum(queries))
    #editedPicnum ? formatPicnum(editedPicnum) : formatPicnum(highlightedPicnum)
    #item.picnum.html_safe
  end
=end
