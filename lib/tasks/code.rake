namespace :code do
  desc 'run reek'
  task all: [:reek, :flay, :rubocop]

  desc 'run reek'
  task :reek do
    Bundler.with_clean_env do
      system 'reek app lib test config'
    end
  end

  desc 'run flay'
  task :flay do
    Bundler.with_clean_env do
      system 'flay app lib test config --mass 64'
    end
  end

  desc 'run rubocop'
  task :rubocop do
    Bundler.with_clean_env do
      system 'rubocop -RD'
    end
  end
end
