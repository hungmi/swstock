class Pc::Procedure < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }
  has_many :stages
  belongs_to :workpiece
end