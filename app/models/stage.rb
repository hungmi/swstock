class Stage < ActiveRecord::Base
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }
  scope :danger, -> { where.not( arrival_date: "" ).where( 'arrival_date < ?', 7.days.ago ) }

  belongs_to :procedure
  belongs_to :factory
  # validates :note, length: { in: 3..100 }
  # OPTIMIZE stage欄位有要排除的的狀況就寫在這裡

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

  def danger?
    running? && (arrival_date < 7.days.ago if arrival_date.present?)
  end

  def update_status_after_import
    finish! if finished_amount.present? && !finished_amount.zero?
  end

  private

  def update_finish_columns
    self.update(finished_date: Date.today.to_s)
    self.next.try(:update, arrival_date: Date.today.to_s)
    self.procedure.finish! unless self.next
  end

end