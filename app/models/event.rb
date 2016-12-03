class Event < ActiveRecord::Base
  belongs_to :group
  belongs_to :location
  accepts_nested_attributes_for :group
  accepts_nested_attributes_for :location

  enum entry_type: [:manual, :automated]
  enum status: [:authorized, :disabled]

  validates :name, :url, :description, :entry_type, :status, :start_time, presence: true
  validates :email, presence: true, if: 'manual?'
  validates :external_id, presence: true, if: 'automated?'
  validate :start_time_validation, if: 'start_time'

  scope :all_events, -> { authorized }
  scope :this_week, -> { authorized.where(start_time: DateTime.current..1.week.from_now) }
  scope :this_month, -> { authorized.where(start_time: DateTime.current..1.month.from_now) }

  class << self
    def future
      joins(:group).where(groups: { status: Group.statuses[:authorized] })
      .where('start_time >= ? ', DateTime.current)
      .order(:start_time)
    end

    def latest
      joins(:group).where(groups: { status: Group.statuses[:authorized] })
      .where(start_time: DateTime.current..3.months.from_now)
      .order(:start_time)
    end

    def prune
      joins(:group).where(groups: { status: Group.statuses[:disabled] })
      .delete_all
    end
  end

  private

  def start_time_validation
    if start_time < DateTime.current
      errors.add(:start_time, 'We accept events in the future only')
    end
  end
end
