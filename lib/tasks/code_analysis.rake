task :code_analysis do
  sh 'bundle exec rubocop app config lib'
  sh 'bundle exec reek app config lib'
  sh 'bundle exec rails_best_practices -e "db/migrate" .'
end
