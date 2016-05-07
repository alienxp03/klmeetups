class Event < ActiveRecord::Base
  belongs_to :group
  belongs_to :location
  accepts_nested_attributes_for :group
  accepts_nested_attributes_for :location

  enum entry_type: [:manual, :automated]
  enum status: [:authorized, :disabled]

  validates :name, :url, :description, :entry_type, :status, :start_time, presence: true
  validates :email, presence: true, if: 'manual?'
  validates :external_id, :group, presence: true, if: 'automated?'

  scope :all_events, -> { authorized }
  scope :this_week, -> { authorized.where(start_time: DateTime.current..1.week.from_now) }
  scope :this_month, -> { authorized.where(start_time: DateTime.current..1.month.from_now) }

  class << self
    def latest
      authorized
      .joins(:group).where(groups: { status: Group.statuses[:authorized] })
      .where(start_time: DateTime.current..3.months.from_now)
    end

    def prune
      joins(:group).where(groups: { status: Group.statuses[:disabled] })
      .delete_all
    end
  end
end
