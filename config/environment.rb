# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['MAILJET_API_KEY'], #adding API Key
  :password => ENV['MAILJET_SECRET_KEY'],
  :domain => 'https://hotefinder-3980cefcc9bb.herokuapp.com',
  :address => 'in-v3.mailjet.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Comments to verify if deployment is working.
