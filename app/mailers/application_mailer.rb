class ApplicationMailer < ActionMailer::Base
  # helper :mailer # gives access to mailer helpers defined within `mailer_helper`.

  default from: "no-reply@#{ENV['MAIN_DOMAIN']}"
  # layout 'mailer'
end