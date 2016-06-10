namespace :crawlers do
  task :crawl => :environment do
    app = ActionDispatch::Integration::Session.new(Rails.application)
    app.get "/api/crawlers"
  end
end
