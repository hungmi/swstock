class Item < ActiveRecord::Base

  include ExcelAccesor

  validates :picnum, presence: true
  validates :location, presence: true
  scope :recent, -> { order(updated_at: :desc) }
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

end
