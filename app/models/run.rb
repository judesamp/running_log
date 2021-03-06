# == Schema Information
#
# Table name: runs
#
#  id         :integer          not null, primary key
#  run_date   :date
#  distance   :float
#  route_name :string(255)
#  notes      :text
#  run_time   :integer
#  user_id    :integer
#

class Run < ActiveRecord::Base
  belongs_to :user
  before_validation :init_data

  validates_presence_of :run_time
  validates_presence_of :distance


  scope :most_recent_by_date, -> { order('run_date desc') }
  scope :in_the_last_week, -> { where( :run_date => 7.days.ago..Date.today)}
  scope :in_the_last_thirty_days, -> { where( :run_date => 30.days.ago..Date.today)}
  scope :in_the_last_year, -> { where( :run_date => 365.days.ago..Date.today)}
  scope :in_the_last_year, -> { where( :run_date => 365.days.ago..Date.today)}


  def per_mile_pace
    if run_time == 0.0 || distance == 0
      "0:00/mile"
    else
      run_time / distance
    end
  end

  def self.total_time(runs)
    run_times = runs.all.pluck(:run_time)
    run_times.reduce(:+)
  end

  def self.total_distance(runs)
    distances = runs.all.pluck(:distance)
    if distances.length > 0
      distances.reduce(:+).round(2)
    else
      0
    end
  end

  def self.all_time_per_mile_pace(runs)
    run_time = total_time(runs)
    distance = total_distance(runs)
    if distance > 0 && run_time > 0
      run_time / distance
    else
      0
    end
  end

  def init_data
    self.run_date ||= Date.today
    self.distance ||= 0
    self.run_time ||= 0.0
  end

end
