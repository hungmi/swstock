class Procedure < ActiveRecord::Base
  include ExcelAccesor
  include AASM

  aasm :whiny_transitions => false do
    state :running, :initial => true
    state :finished

    event :finish do
      transitions from: :running, to: :finished
    end
  end

  scope :paginated, -> (page) { paginate(:per_page => 3, :page => page) }

  has_many :stages, dependent: :destroy
  accepts_nested_attributes_for :stages, allow_destroy: true, reject_if: :all_blank
  # 此處是給進入製程頁面編輯時使用的stage validation
  
  # def note_too_long(attributes)
  #   attributes['note'].length > 10
  # end

  belongs_to :workpiece

  def fork
    forked_proc = self.class.new attributes.except!('id', 'start_date')
    today = Date.today.to_s
    forked_proc.start_date = today
    stages.each do |stage|
      new_stage = forked_proc.stages.new
      if forked_proc.stages.size == 1
        new_stage.arrival_date = today
      end
      new_stage.factory_name = stage.factory_name
      new_stage.note = stage.note
    end
    forked_proc
  end

  after_save :update_status_if_any_stage

  def update_status_if_any_stage
    if self.stages.exists?
      self.stages.each do |stage|
        #stage.update_status
        stage.note = 'from Procedure'
        stage.save
      end
    end
  end 

end