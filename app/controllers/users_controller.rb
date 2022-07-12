class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      redirect_to login_path, notice: "Signed up!"
    else
      render :new
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to login_path, notice: "User was successfully activated."
    else
      not_authenticated
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def strong_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

