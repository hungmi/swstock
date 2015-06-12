module ApplicationHelper

  def comment; end

  def active_when(link_path)
    "active" if request.fullpath == link_path    
  end

  def render_nav_link(text, link_path)
    content_tag(:li, link_to(text, link_path), :class => active_when(link_path))
  end

  def clear_format(text)
    text.gsub(/^$\n/,'').tr('（），。','(), ')
  end

  def count_row(text, num)
    row_num = 0
    if !text.nil?
      text = text.gsub(/\n$/,'')

      text.each_line do |line|
        line.length > num ? row_num += 1 + (line.length / num) : row_num += 1
      end
    end
    return row_num
  end

  def render_table_header(text, size, addtonal_class)
    content_tag(:th, text, :class => "#{size}Cell #{addtonal_class}")
  end

  def render_table_data(&block)
    content_tag(:td, :class => "aaaa") do
      block
    end
  end

end
