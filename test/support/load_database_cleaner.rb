require 'database_cleaner'

DatabaseCleaner.clean_with :truncation

DatabaseCleaner.strategy = :transaction
