module Api
  class OauthController < ApiApplicationController
    skip_before_filter :authorize!

    def index
      if Oauth.first
        message('Already authorized')
      else
        @@oauth ||= Koala::Facebook::OAuth.new(
          ENV['FACEBOOK_APP_ID'],
          ENV['FACEBOOK_APP_SECRET'],
          "#{request.base_url}/oauth/callback"
        )
        redirect_to @@oauth.url_for_oauth_code({ permissions: 'user_managed_groups' })
      end
    end

    def callback
      access_token = @@oauth.get_access_token(params[:code])
      if Oauth.new(access_token: access_token).save
        if session[:referer]
          redirect_to session[:referer]
          session[:referer] = nil
        else
          message('Authorization updated')
        end
      else
        error('Failed to authorized')
      end
    end
  end
end
