# Api::OauthController

module Api
  class OauthController < ApiApplicationController
    skip_before_filter :authorize!

    def index
      if Oauth.first
        message('Already authorized')
      else
        request_authorization
      end
    end

    def callback
      access_token = @@oauth.get_access_token(params[:code])
      if Oauth.new(access_token: access_token).save
        redirect_on_success
      else
        error('Failed to authorized')
      end
    end

    private

    def request_authorization
      @@oauth ||= Koala::Facebook::OAuth.new(
        ENV['FACEBOOK_APP_ID'],
        ENV['FACEBOOK_APP_SECRET'],
        "#{request.base_url}/oauth/callback"
      )
      redirect_to @@oauth
        .url_for_oauth_code(permissions: 'user_managed_groups')
    end

    def redirect_on_success
      referer = session[:referer]
      if referer
        redirect_to referer
        session[:referer] = nil
      else
        message('Authorization updated')
      end
    end
  end
end
