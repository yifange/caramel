class ResetPwdMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reset_pwd_mailer.send_pwd.subject
  #
  def send_pwd(user)
    @user = user
    mail to: @user.email, subject: "Reset your MusicKids Password"
  end
end
