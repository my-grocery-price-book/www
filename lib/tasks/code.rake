namespace :code do
  desc 'run reek'
  task all: [:reek, :rubocop]

  desc 'run reek'
  task :reek do
    Bundler.with_clean_env do
      system 'reek app lib test config'
    end
  end

  desc 'run rubocop'
  task :rubocop do
    Bundler.with_clean_env do
      system 'rubocop -RD'
    end
  end
end
