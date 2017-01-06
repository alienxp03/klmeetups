module Api
  class ApplicationController < ActionController::Base
    def message(message)
      render json: { message: message }
    end

    def error(message)
      render json: { error: message }
    end
  end
end
