class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :pretty_date, :pretty_pace, :current_user
  # before_filter :ensure_logged_in

  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_logged_in
    if current_user.nil?
      redirect_to root_path, notice: "You are not logged in"
    end
  end


  def pretty_date(run_date)
    if run_date.present?
      run_date.strftime("%B %e")
    else
      "NA"
    end
  end

  def pretty_pace(pace)
    if pace == "0:00/mile"
      "0:00/mile"
    else
      time_pieces = pace.divmod 1
      minutes = time_pieces[0]
      seconds = time_pieces[1] * 0.6
      seconds = seconds.round(2)
      seconds = (seconds * 100).to_i
      if seconds < 10
        seconds = "0#{seconds}"
      end
      "#{minutes}:#{seconds}/mile"
    end
  end
end
