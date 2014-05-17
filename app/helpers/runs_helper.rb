module RunsHelper

  def pretty_date(run_date)
    run_date.strftime("%B %e")
  end

  def pretty_time(minutes)
    hours = minutes / 60
    minutes = minutes % 60
    if hours == 0
      "#{minutes}m"
    else
      "#{hours}h, #{minutes}m"
    end
  end

  def pretty_pace(pace)
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
