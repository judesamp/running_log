class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :pretty_date, :pretty_pace


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
