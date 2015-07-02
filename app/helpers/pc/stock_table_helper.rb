module Pc::StockTableHelper
  def render_clipboard_content(item)
    orginal_item = @orginal_items.find(item.id)
    content_tag(:textarea, "#{orginal_item.location}\t\"#{orginal_item.picnum.gsub("\n",'').gsub("+", "\r\n")}\"", class:'stock_table_clipboard', rows:'4')
  end
end