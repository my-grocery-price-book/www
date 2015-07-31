# Load the Rails application.
if ENV['RDS_DB_NAME'] && ENV['RDS_USERNAME']
  ENV['DATABASE_URL'] = "postgresql://#{ENV['RDS_USERNAME']}:#{ENV['RDS_PASSWORD']}@#{ENV['RDS_HOSTNAME']}:#{ENV['RDS_PORT']}/#{ENV['RDS_DB_NAME']}?pool=5"
end
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
