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
      transitions from: :sleeping, to: :running, guard: :valid_run_amount?
    end
    event :move do
      transitions from: :running, to: :moving
    end
    event :finish do
      transitions from: [:sleeping, :running], to: :finished, guard: :valid_finished_amount?, after: :update_finish_columns
    end
  end

  def valid_run_amount?
    arrival_amount.present? && !arrival_amount.zero?
  end

  def valid_finished_amount?
    finished_amount.present? && !(finished_amount < 1)
  end

  def update_status_after_import
    finish! if valid_finished_amount?
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

  private

  def update_finish_columns
    self.update(finished_date: Date.today) if self.finished_date.blank?
    if self.finished_amount < self.arrival_amount
      if self.broken_amount.blank? || self.broken_amount < 1
        self.update(broken_amount: self.arrival_amount - self.finished_amount)
      end 
    end
    self.next.try(:update, arrival_date: Date.today) if self.next.arrival_date.blank? if self.next
    self.next.try(:update, arrival_amount: self.finished_amount) if self.next
    self.next.run! if self.next
    self.procedure.finish! unless self.next
  end

end