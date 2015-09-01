class Pc::Procedure < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 5, :page => page) }

  has_many :stages
  accepts_nested_attributes_for :stages, reject_if: :all_blank, allow_destroy: true
  
  belongs_to :workpiece

  def fork
    forked_proc = self.class.new attributes.except!('id', 'start_date')
    forked_proc.start_date = Date.today.to_s
    stages.each do |stage|
      new_stage = forked_proc.stages.new
      new_stage.factory_name = stage.factory_name
      new_stage.note = stage.note
    end
    forked_proc
  end

end