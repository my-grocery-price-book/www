if ENV['LOG_TO_SYSLOG']
  require 'syslog/logger'
  Rails.application.config.logger = Syslog::Logger.new 'my_grocery_book'
end
