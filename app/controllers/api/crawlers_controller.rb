module Api
  class CrawlersController < Api::ApplicationController
    def index
      Api::FacebookController.update_events
      Api::MeetupController.update_events
      # Api::Crawlers::EventbriteController.create_or_update_events

      render json: {
        status: 201,
        message: 'Events added!'
      }
    end
  end
end
