# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
UnknownBusiness::Application.initialize!

config.action_mailer.delivery_method = :smtp

ActionMailer::Base.smtp_settings = { :address => "smtp.gmail.com", :port => 465, :user_name => "ryanklimt@gmail.com", :password => "ryanjohn", :authentication => :login}