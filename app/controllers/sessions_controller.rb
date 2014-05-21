class SessionsController < ApplicationController
  skip_filter :ensure_logged_in

  def new

  end

  def create
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_runs_path(user), notice: "logged in"
    else
      flash.now.alert = "Invalid email or password."
      render :back
    end

  end

  def destroy
    puts 'here'
    session[:user_id] = nil
    redirect_to root_path, notice: "You logged out!"
  end
end