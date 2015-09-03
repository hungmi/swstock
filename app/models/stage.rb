class Stage < ActiveRecord::Base
  include AASM

  aasm :whiny_transitions => false do
    state :sleeping, :initial => true
    state :running
    state :paused
    state :finished

    event :run do
      transitions from: [:sleeping, :paused], to: :running
    end

    event :finish do
      transitions from: :running, to: :finished
    end

    event :pause do
      transitions from: :running, to: :paused
    end
  end

  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  belongs_to :procedure
  belongs_to :factory

  before_save :update_status

  def update_status    
    if finished.present? && finish_date.present?
      self.finish
    elsif arrival_date.present?
      true #self.run
    end
  end

end