module ApplicationHelper
  def comment; end

  def count_row(text,num)
    rowNum = 0
    if !text.nil?
      text = text.gsub(/\n$/,'')

      text.each_line do |line|
        line.length > num ? rowNum += 1 + (line.length/num) : rowNum += 1
      end
    end
    return rowNum
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
