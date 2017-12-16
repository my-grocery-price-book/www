# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # helper :mailer # gives access to mailer helpers defined within `mailer_helper`.

  default from: 'no-reply@my-grocery-price-book.co.za'
  # layout 'mailer'
end
