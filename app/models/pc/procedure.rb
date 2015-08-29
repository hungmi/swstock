class Pc::Procedure < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 5, :page => page) }

  has_many :stages
  accepts_nested_attributes_for :stages, reject_if: :all_blank, allow_destroy: true
  
  belongs_to :workpiece
end