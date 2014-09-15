class AddPropertiesToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :user_id, :integer
    add_column :locations, :latitude, :decimal
    add_column :locations, :longitude, :decimal
    add_column :locations, :recorded_at, :timestamp
  end
end
