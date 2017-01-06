namespace :events do
  task :search => :environment do
    Crawlers::ApplicationController.new.search
  end
end
