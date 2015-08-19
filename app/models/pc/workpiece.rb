class Pc::Workpiece < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  has_many :procedures

  include ExcelAccesor
  
end