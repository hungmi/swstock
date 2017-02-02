class Item < ActiveRecord::Base
  scope :recent, -> { order(updated_at: :desc) }
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  validates :picnum, presence: true
  validates :location, presence: true

  include ExcelAccesor

  def customer_color
  	return Customer.find_by_name(self.customer).try(:color)
  end

  def clipboard_picnum
  	result = self.picnum.gsub("+","")
  	first = self.location
  	second = result.scan(/\D+/).join("\r\n\"")
  	third = result.scan(/[0-9]+/).join("\r\n\"")
  	return result = first + "\t\"" + second + "\t\"" + third
  end

end
