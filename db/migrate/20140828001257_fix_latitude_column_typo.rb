class FixLatitudeColumnTypo < ActiveRecord::Migration
  def change
  	rename_column :events, :latitute, :latitude
  end
end


