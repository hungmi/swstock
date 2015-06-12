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
    # Search result is an array, present? is for array.
    params[:search].nil? ? @items.exists? : @items.present?
  end

  def render_picnum_if(picnum, condition)
    return '' if !picnum.present?
    if condition
      emphasize_picnum(picnum, condition) # use condition here is so weired!!!!!!
    else
      render_picnum(picnum)
    end
  end

  def render_item_note(note)
    if note.present?
    raw("<%= f.text_area :note, :value => item.note.gsub(/\n$/,''), rows: count_row(item.note,20), id: submit_id %>")
    else
      raw("<%= f.text_area :note, rows: 1, id: submit_id %>")
    end
    
  end

end
