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

    def eventbrite
      authorized.where('url LIKE ?', '%eventbrite.com/%')
    end
  end

  private

  def origin
    if url.include? 'facebook.com/'
      'Facebook'
    elsif url.include? 'meetup.com/'
      'Meetup'
    elsif url.include? 'eventbrite.com/'
      'Eventbrite'
    else
      nil
    end 
  end

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
