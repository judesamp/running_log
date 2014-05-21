class UsersController < ApplicationController
  skip_filter :ensure_logged_in, only: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_runs_path(@user)
    else
      redirect_to users_path, notice: "Something went wrong:) Please try loggin in again."
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end