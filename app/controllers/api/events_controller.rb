# Api::EventsController

module Api
  class EventsController < Api::ApplicationController
    def index
      @events = Event.latest
    end
  end
end
