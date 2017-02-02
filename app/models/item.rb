class Item < ActiveRecord::Base
  scope :recent, -> { order(updated_at: :desc) }
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  validates :picnum, presence: true
  validates :location, presence: true

  include ExcelAccesor

  def customer_color
  	return Customer.find_by_name(self.customer).try(:color)
  end

end
