class Stage < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  belongs_to :procedure
  belongs_to :factory

  include AASM
  aasm :whiny_transitions => false do
    state :sleeping, initial: true
    state :moving
    state :running
    state :finished

    event :run do
      transitions from: :sleeping, to: :running
    end
    event :move do
      transitions from: :running, to: :moving
    end
    event :finish do
      transitions from: [:sleeping, :running], to: :finished
    end
  end

  def next
    self.procedure.stages.order(:id).where("id > ?", id).first
  end

  def previous
    self.procedure.stages.order(:id).where("id < ?", id).last
  end

  after_save :update_status

  private

  def update_status
    if finished_amount.present? && finished_date.present?
      self.finish!
      if self.next.nil?
        if self.procedure.finish!
          self.note = "it's me"
          self.save
        end
      else
        if self.next.arrival_date
          self.run!
        else
          self.move!
        end
      end
    elsif arrival_date.present?      
      self.run!
    end
  end

end