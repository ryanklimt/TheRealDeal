class UserMailer < ActionMailer::Base
  default from: "noreply@ultimatebeta.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset", :from => "noreply@ultimatebeta.com"
  end
  
  def verify_email(user)
    @user = user
    mail :to => user.email, :subject => "Verify Your Email", :from => "noreply@ultimatebeta.com"
  end
  
end
