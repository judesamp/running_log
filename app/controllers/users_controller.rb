class UsersController < ApplicationController
  skip_filter :ensure_logged_in

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      redirect_to user_runs_path(user), notice: "Thanks for signing up. You've also been logged in."
    else
      redirect_to users_path, notice: "Something went wrong:) Please try logging in again."
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end