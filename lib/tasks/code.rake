namespace :code do
  desc 'run overcommit'
  task :overcommit do
    Bundler.with_clean_env do
      system 'overcommit --run'
    end
  end
end
