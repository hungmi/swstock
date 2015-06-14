module PicnumHelper

  def render_picnums # 此方法比之前作法少了將圖號數字部份挑成陣列再辨識的步驟, 已測試過中英混搭的狀況無誤.

    # Don't use nil? because nil? is true only when nil.
    #   "".nil? => false
    #   !"".present? && !nil.present? => true.
    return @items = [] if @items.size <= 1 # @items沒找到的時候= #<ActiveRecord::Relation []>.size == 0

    if @query_array # Check if available. Get from validate_search_key in items_controller

      @targets = {}
      
      @items.each { |item| get_4_before_query(item.picnum) } # 此方法只針對新圖號作前四碼加強

      #return @items if @targets.size < 2 # '只有一個(或沒有)'就不需要加強了

      assign_different_colors

      if @targets.size > 1
        
        @items.each do |item|
          item.picnum = highlight_picnum_differences(item.picnum) # 此方法只針對新圖號作前四碼加強
          item.picnum = break_into_lines(item.picnum)
          item.oldpicnum = break_into_lines(item.oldpicnum) if item.oldpicnum
        end

        return @items

      end

    end

    @items.each do |item|
      item.picnum = break_into_lines(item.picnum)
      item.oldpicnum = break_into_lines(item.oldpicnum) if item.oldpicnum
    end

  end

  def get_4_before_query(picnum)
    @query_array.each do |query|
      query_index = picnum.index(query)
      # 抓到重複的前四碼字串不需判斷，因為同樣的key再assign一次nil而已。
      @targets[picnum[query_index-4..query_index-1]] = nil if picnum[query] # == query_index.present?
    end
  end


  # @targets = { key[0]: nil, key[1]: nil, ...}
  #   =>  @targets = { key[0]: colors[0], key[1]: colors[1], ...}
  def assign_different_colors
    @targets.each_with_index { |(key, value), index| @targets[key] = @colors[index] }
  end

  def highlight_picnum_differences(picnum)
    @targets.each do |key, value|
      styles = content_tag(:span, '\1', style:"color:#{value};font-size:30px;")
      picnum = highlight(picnum, key, highlighter: styles)
    end
    return picnum
  end

  def break_into_lines(picnum)
    if picnum
      styles = "<br>#{ content_tag(:span, '+', style: 'margin-right:3em; font-size: 26px; color:red;') }<br>"
      picnum = highlight(picnum, @query_array) if @query_array #有搜尋的話先標註出搜尋的字
      picnum.gsub('+', styles)
    end
  end

end