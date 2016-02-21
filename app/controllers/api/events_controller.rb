module Api
  class EventsController < ApiApplicationController
    def index
      if !Event.updated?
        Api::FacebookController.update_events
        Api::MeetupController.update_events

        BaseApi.first.update(last_updated: Time.now)
      end
      @events = Event.latest
      @base_api = BaseApi.first
    end
  end
end
