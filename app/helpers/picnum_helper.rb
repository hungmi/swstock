module PicnumHelper

  def render_picnums # 此方法比之前作法少了將圖號數字部份挑成陣列再辨識的步驟, 已測試過中英混搭的狀況無誤.

    # Don't use nil? because nil? is true only when nil.
    #   "".nil? => false
    #   !"".present? && !nil.present? => true.
    return @items = [] if !@items.present?

    if @query_array # Check if available. Get from validate_search_key in items_controller

      @targets = {}
      
      @items.each { |item| get_4_before_query(item.picnum) }

      return @items if @targets.size == 1

      assign_different_colors

      @items.each do |item|
        item.picnum = highlight_picnum_differences(item.picnum)
        item.picnum = break_into_lines(item.picnum)
      end

    end

  end

  def get_4_before_query(picnum)
    @query_array.each do |query|
      query_index = picnum.index(query)
      if query_index.present?
        # 抓到重複的前四碼字串不需判斷，因為同樣的key再assign一次nil而已。
        @targets[picnum[query_index-4..query_index-1]] = nil
      end
    end
  end

  def assign_different_colors
    @targets.each_with_index do |(key, value), index| # @targets = { key[0]: nil, key[1]: nil, ...}
      @targets[key] = @colors[index]
    end # @targets = { key[0]: colors[0], key[1]: colors[1], ...}
  end

  def highlight_picnum_differences(picnum)
    @targets.each do |key, value|
      styles = content_tag(:span, '\1', style:"color:#{value};font-size:30px;")
      picnum = highlight(picnum, key, highlighter: styles)
    end
    return picnum
  end

  def break_into_lines(picnum)
    if picnum.present?
      styles = "<br>#{ content_tag(:span, '+', style: 'margin-right:3em; font-size: 26px; color:red;') }<br>"
      picnum = picnum.gsub('+', styles)
      highlight(picnum, @query_array) #最後標註出搜尋的字
    end
  end

end