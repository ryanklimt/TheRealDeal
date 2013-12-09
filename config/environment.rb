# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
UnknownBusiness::Application.initialize!

ActionMailer::Base.smtp_settings = { :address => "smtp.gmail.com", :port => 465, :user_name => "ryanklimt@gmail.com", :password => "Ryanjohn64", :authentication => :login}