class Stage < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  include ExcelAccesor
  
end