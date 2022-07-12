 class UserMailer < ActionMailer::Base

 default from: 'yourapp.com <info@yourapp.com>', template_path: "mailers/user_mailer"
  add_template_helper(ApplicationHelper)

  layout 'mailer'

  def activation_needed_email(user)
    @user = user
    @url  = "#{root_url}users/#{user.activation_token}/activate"
    mail to: user.email,
         subject: "Welcome to My Awesome Site"
  end

  def activation_success_email(user)
    @user = user
    @url  = "#{root_url}login"
    mail to: user.email,
         subject: "Your account is now activated"
  end

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail :to => user.email,
         :subject => "Your password has been reset"
  end

 end