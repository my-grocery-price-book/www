namespace :code do
  desc 'run reek'
  task all: [:reek, :flay, :rubocop]

  desc 'run reek'
  task :reek do
    Bundler.with_clean_env do
      system 'reek app lib test config'
    end
  end

  FLAY_MASS = 53

  desc 'run flay'
  task :flay do
    Bundler.with_clean_env do
      system "flay app lib test config --mass #{FLAY_MASS}"
    end
  end

  desc 'run flay'
  task :flay_ci do
    Bundler.with_clean_env do
      output = `flay app lib test config --mass #{FLAY_MASS}`
      puts output
      unless output.include? 'Total score (lower is better) = 0'
        abort 'flay failed'
      end
    end
  end

  desc 'run rubocop'
  task :rubocop do
    Bundler.with_clean_env do
      system 'rubocop -RD'
    end
  end
end
