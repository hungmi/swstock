class Procedure < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 3, :page => page) }

  after_save :auto_arrive_first_stage

  has_many :stages, dependent: :destroy
  accepts_nested_attributes_for :stages, allow_destroy: true, reject_if: :all_blank

  include ExcelAccesor
  include AASM

  aasm :whiny_transitions => false do
    state :running, :initial => true
    state :finished

    event :finish do
      transitions from: :running, to: :finished, after: :finish_forgotten_stages
    end
  end

  def auto_arrive_first_stage
    if self.stages.present? && self.stages.first.arrival_date.nil?
      self.stages.try(:first).try(:update, arrival_date: start_date)
    end
  end

  def finish_forgotten_stages
    self.stages.update_all(aasm_state: 'finished')
  end
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
        new_stage.run
      end
      new_stage.factory_name = stage.factory_name
      new_stage.note = stage.note
    end
    forked_proc
  end

  def danger?
    ((start_date < 30.days.ago) || stages.danger.exists?) && running?
  end

end