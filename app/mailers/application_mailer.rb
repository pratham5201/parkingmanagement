# frozen_string_literal: true

# application mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'demot378@gmail.com'
  layout 'mailer'
end
