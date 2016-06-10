module Api
  class CrawlersController < Api::ApplicationController
    def crawl
      Api::FacebookController.update_events
      Api::MeetupController.update_events
      Api::Crawlers::EventbriteController.create_or_update_events
    end

    def index
      old_total = Event.count
      crawl

      render json: {
        status: 201,
        message: "#{Event.count - old_total} events added!"
      }
    end
  end
end
