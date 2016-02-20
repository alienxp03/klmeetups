module Api
  class ApiApplicationController < ActionController::Base
    before_action :authorize!, except: [:oauth]

    attr_accessor :fb_api

    def authorize!
      oauth = Oauth.first

      if oauth
        @fb_api ||= Koala::Facebook::API.new(oauth.access_token)
      else
        session[:referer] = request.url
        redirect_to '/oauth'
      end
    end

    def message(message)
      render json: { message: message }
    end

    def error(message)
      render json: { error: message }
    end
  end
end
