class FixUsersDefaults < ActiveRecord::Migration
  def change
    change_column_default :runs, :distance, nil
    change_column_default :runs, :run_date, nil
    change_column_default :runs, :run_time, nil
  end
end
