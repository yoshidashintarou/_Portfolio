class PasswordResetsController < ApplicationController
   skip_before_filter :require_login

  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    redirect_to login_url, notice: 'Instructions have been sent to your email.'
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    if @user.blank?
      not_authenticated
      return
    end
    # it makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # it clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      redirect_to login_path, notice: 'Password was successfully updated.'
    else
      render :edit
    end
  end

end
