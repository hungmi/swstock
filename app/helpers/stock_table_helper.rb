module StockTableHelper  

  def clear_format(text)
    text.gsub(/\r+|\n+/, "\n").squeeze("\n").squeeze(" ").tr('（），。','(), ') if text
  end

  def count_row(text, num)
    row_num = 0
    if text
      clear_format(text)
      text.each_line { |line| line.length > num ? row_num += 1 + (line.length / num) : row_num += 1 }
      return row_num
    end
    return 1
  end

  def render_table_header(text, size, addtonal_class)
    content_tag(:th, text, :class => "#{size}Cell #{addtonal_class}")
  end
=begin
  def render_table_data(&block)
    content_tag(:td, :class => "aaaa") do
      block
    end
  end

  def render_item_note(note)
    if note.present?
    raw("<%= f.text_area :note, :value => item.note.gsub(/\n$/,''), rows: count_row(item.note,20), id: submit_id %>")
    else
      raw("<%= f.text_area :note, rows: 1, id: submit_id %>")
    end
    
  end
=end
  def style_customer(customer_color)
    style_customer = "background-color:#{customer_color}"
  end
  
  def item_id_to_tag_id(item)
    "edit_item_#{item.id}"
  end

end