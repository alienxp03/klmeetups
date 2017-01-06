web: bundle exec passenger start -p $PORT
worker: bundle exec sidekiq -c 7 -q default -q quotes
