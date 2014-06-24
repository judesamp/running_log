class SessionsController < ApplicationController
  skip_filter :ensure_logged_in

  def new
  end

  # POST /login
  # create session/login user
  def create
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_runs_path(user), notice: "logged in"
    else
      redirect_to root_path, notice: "There was a real problem! You are not logged in."
    end
  end

  # DELETE /session/:id
  # delete session/logout user
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You logged out!"
  end
end