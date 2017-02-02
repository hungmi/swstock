module StockTableInitializer
  extend ActiveSupport::Concern

  included do
    attr_reader :customer_colors, :customer_names, :table_titles, :colors
    before_action :set_customers, :set_table_titles, :set_colors
  end

  def set_customers
    # items/partial/_form.html.erb need
    # @customer_colors = {'富暘' => 'palegreen', '油機' => 'lightcoral', '東台' => 'steelblue', '金玉' => 'darkorange'}
    # #98fb98, #f08080, #4682b4, #ff8c00
    @customers =  Customer.all.pluck(:name) # ['富暘', '油機', '東台', '金玉']
    # Not to use one hash because when select customer, the stored value would be colors.
    #   which results in unsearchable customers.
  end

  def set_table_titles
    # items/partial/_stock_table.html.erb need @table_titles
    @table_titles = { '櫃位' => 'sm', '圖號'=>'lg', ''=>'xs', '舊圖號'=>'lg', '提醒'=>'lg', '成品'=>'sm', '半成品'=>'sm' }
  end

  def set_colors
    @colors = ['royalblue', 'ORANGERED', 'darkviolet', 'darkorange', 'slatgray', 'saddlebrown', 'goldenrod', 'darkcyan', 'limegreen', 'red']
  end
end