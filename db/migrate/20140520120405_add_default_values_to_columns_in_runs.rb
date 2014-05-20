class AddDefaultValuesToColumnsInRuns < ActiveRecord::Migration
  def change
    change_column :runs, :distance, :float, :default => 0
    change_column :runs, :run_date, :date, :default => Date.today
    change_column :runs, :run_time, :integer, :default => 0
  end
end
