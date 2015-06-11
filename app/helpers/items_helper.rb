module ItemsHelper
  def item_id_to_tag_id(item)
    "edit_item_#{item.id}"
  end

  def render_picnum(picnum)
    styles = content_tag(:br, content_tag(:span, "+", style: "margin-right:3em; font-size: 26px; color:red;"))
    #styles = '<br><span style="margin-right:3em; font-size: 26px; color:red;">+</span><br>'
    picnum.gsub('+', styles).html_safe
  end

  def items_available?
    if @items.is_a?(Array) # Array condition is for search
      @found = true if @items.present?
    elsif @items.exists?
      @found = true
    else
      @found = false
    end
  end

end
