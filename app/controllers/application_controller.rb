class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :reload_rails_admin, if: :rails_admin_path?

  private

  def reload_rails_admin
    models = %W(Event Group)
    models.each do |m|
      RailsAdmin::Config.reset_model(m)
    end
    RailsAdmin::Config::Actions.reset

    load("#{Rails.root}/config/initializers/rails_admin.rb")
  end

  def rails_admin_path?
    controller_path =~ /rails_admin/ && Rails.env.development?
  end
end
