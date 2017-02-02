module Pc::StockTableHelper
  def render_clipboard_content(item)
    orginal_item = @orginal_items.find(item.id)
    # content_tag(:textarea, "#{orginal_item.location}\t\"#{orginal_item.picnum.gsub("\n",'').gsub("+", "\r\n")}\"", class:'stock_table_clipboard', rows:'4', style:"#{black_style_customer(item.customer_color)}")
    content_tag(:textarea, orginal_item.clipboard_picnum, class:'stock_table_clipboard', rows:'4', style:"#{black_style_customer(item.customer_color)}")
  end

  def black_style_customer(customer_color)
    style_customer = "color:black; background-color:#{customer_color};" if customer_color.present?
  end
end