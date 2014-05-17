class Run < ActiveRecord::Base

  scope :most_recent_by_date, -> { order('run_date desc') }
  scope :in_the_last_week, -> { where( :run_date => 7.days.ago..Date.today)}
  scope :in_the_last_thirty_days, -> { where( :run_date => 30.days.ago..Date.today)}
  scope :in_the_last_year, -> { where( :run_date => 365.days.ago..Date.today)}
  scope :in_the_last_year, -> { where( :run_date => 365.days.ago..Date.today)}


  def per_mile_pace
    run_time / distance
  end

  def self.total_time
    run_times = Run.all.pluck(:run_time)
    run_times.reduce(:+)
  end

  def self.total_distance
    distances = Run.all.pluck(:distance)
    distances.reduce(:+)
  end

  def self.all_time_per_mile_pace
    run_time = total_time
    distance = total_distance
    run_time / distance
  end

end