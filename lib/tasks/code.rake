namespace :code do
  desc 'run overcommit'
  task :overcommit do
    Bundler.with_clean_env do
      system 'overcommit --run'
    end
  end

  desc 'run foreman'
  task :foreman do
    Bundler.with_clean_env do
      exec 'foreman start'
    end
  end

  desc 'tail'
  task :tail do
    Bundler.with_clean_env do
      exec 'tail -f log/development.log'
    end
  end
end
