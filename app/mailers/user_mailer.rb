class UserMailer < ApplicationMailer
  default(from: 'steven@email.com')

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to OdinBook!')
  end
end
