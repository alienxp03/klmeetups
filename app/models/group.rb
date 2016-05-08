class Group < ActiveRecord::Base
  has_many :events
  enum status: [:authorized, :disabled]

  scope :all_groups, -> { authorized }

  validates :external_id, :name, :status, :url, presence: true
  validates :external_id, uniqueness: true

  after_update :update_events

  class << self
    def facebook
      authorized.where('url LIKE ?', '%facebook.com/%')
    end

    def meetup
      authorized.where('url LIKE ?', '%meetup.com/%')
    end
  end

  private

  def update_events
    status =
      if authorized?
        Event.statuses[:authorized]
      else
        Event.statuses[:disabled]
      end

    events.each do |event|
      event.update(status: status)
    end
  end
end
