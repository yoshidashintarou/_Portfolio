class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to user_path(user), notice: "Logged in!"
    else
      invalid_user = User.find_by_email(params[:email])
      message = (invalid_user.present? && invalid_user.locked?) ? "This account is locked" : "Email or password was invalid"
      flash.now[:alert] = message
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "Logged out!"
  end

end