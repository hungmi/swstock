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
      transitions from: [:sleeping, :running], to: :finished, after: :update_finish_columns
    end
  end

  def next
    self.procedure.stages.order(:id).where("id > ?", id).first
  end

  def previous
    self.procedure.stages.order(:id).where("id < ?", id).last
  end

  private

  def update_finish_columns
    self.update(finished_date: Date.today.to_s)
    self.next.try(:update, arrival_date: Date.today.to_s)
  end

end