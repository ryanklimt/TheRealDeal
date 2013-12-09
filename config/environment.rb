# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
UnknownBusiness::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "app20109224@heroku.com",
  :password => "tj23ktel",
  :domain => "www.ultimatebeta.com",
  :address => "smtp.sendgrid.net", 
  :port => 586,
  :authentication => :plain,
  :enable_starttls_auto => true
}