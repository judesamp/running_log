class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.date :run_date
      t.float :distance
      t.string :route_name
      t.text :notes
      t.integer :run_time
    end
  end
end
