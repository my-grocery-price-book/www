unless ENV['MUTANT']
  SimpleCov.start do
    add_filter 'vendor/bundle'
    add_filter 'db/migrations'
  end
  SimpleCov.minimum_coverage 99
end
