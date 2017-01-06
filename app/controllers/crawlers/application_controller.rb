module Crawlers
  class ApplicationController < ActionController::Base
    def search
      @messages = []
      search_meetup
      search_eventbrite
      search_facebook

      head :ok
    end

    def self.make_request(url)
      JSON.parse(HTTP.get(url).to_s)
    end

    private

    def search_meetup
      old_meetups = Event.where(group_id: Group.meetup.map(&:id)).count
      MeetupController.search_events
      new_meetups = Event.where(group_id: Group.meetup.map(&:id)).count

      if new_meetups > old_meetups
        @messages << "Found #{new_meetups - old_meetups} meetups from Meetup.com"
      end
    end

    def search_eventbrite
      old_meetups = Event.where(group_id: Group.eventbrite.map(&:id)).count
      EventbriteController.search_events
      new_meetups = Event.where(group_id: Group.eventbrite.map(&:id)).count

      if new_meetups > old_meetups
        @messages << "Found #{new_meetups - old_meetups} meetups from Eventbrite"
      end
    end

    def search_facebook
      old_meetups = Event.where(group_id: Group.facebook.map(&:id)).count
      FacebookController.search_events
      new_meetups = Event.where(group_id: Group.facebook.map(&:id)).count

      if new_meetups > old_meetups
        @messages << "Found #{new_meetups - old_meetups} meetups from Facebook"
      end
    end
  end
end
