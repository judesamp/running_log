class FixFloatIssue < ActiveRecord::Migration
  def change
    change_column :runs, :distance, :float, :default => 0.0
  end
end
