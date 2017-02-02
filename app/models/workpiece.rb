class Workpiece < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  has_many :procedures
  
  def running_count
    sum = 0
    self.procedures.running.each do |p|
      sum += p.stages.running.last.arrival_amount if p.stages.running.exists?
    end
    return sum
  end
end