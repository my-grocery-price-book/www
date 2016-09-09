namespace :code do
  desc 'run reek'
  task :reek do
    Bundler.with_clean_env do
      exec 'reek app lib test config'
    end
  end
end
