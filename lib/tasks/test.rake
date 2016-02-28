namespace :test do
  unless Rails.env == 'production'
    require 'rspec/core/rake_task'
    require 'rubocop/rake_task'
    require 'reek/rake/task'

    desc 'Execute Rspec'
    RSpec::Core::RakeTask.new(:spec) do |task|
      task.rspec_opts = '--format p'
    end

    desc 'Execute rubocop -DR'
    RuboCop::RakeTask.new(:rubocop) do |task|
      task.options = ['-DR'] # Rails, display cop name
      task.fail_on_error = false
    end

    desc 'Execute reek'
    Reek::Rake::Task.new do |task|
      task.source_files = '{app/**/*.rb,lib/**/*.rb,' \
                          'lib/tasks/*.rake,config/**/*.rb}'
      task.fail_on_error = false
      task.verbose = true
    end

    desc 'Execute rails_best_practices'
    task rbp: :environment do
      require 'rails_best_practices'
      analyzer = RailsBestPractices::Analyzer.new('.')
      analyzer.analyze
      puts analyzer.output
    end
  end
end

task :test do
  %w(rubocop reek rbp spec).each do |task|
    Rake::Task["test:#{task}"].invoke
  end
end
