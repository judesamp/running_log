class RemoveDefaultValues < ActiveRecord::Migration
  def change
    change_column :runs, :distance, :float
    change_column :runs, :run_date, :date
    change_column :runs, :run_time, :integer
  end
end
