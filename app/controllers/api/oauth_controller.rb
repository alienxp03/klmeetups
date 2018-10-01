module Api
  class OauthController < Api::ApplicationController
    def refresh_access_token
      render json: { access_token: 'access_token_yo' }
    end

    def index
      if Setting.facebook_access_token
        message('Already authorized')
      else
        request_authorization
      end
    end

    def callback
      access_token = @@oauth.get_access_token(params[:code])
      Setting.facebook_access_token = access_token
      redirect_on_success
    end

    private

    def request_authorization
      @@oauth ||= Koala::Facebook::OAuth.new(
        ENV['FACEBOOK_APP_ID'],
        ENV['FACEBOOK_APP_SECRET'],
        "#{request.base_url}/oauth/callback"
      )
      redirect_to @@oauth
        .url_for_oauth_code(permissions: 'groups_access_member_info')
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
