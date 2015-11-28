class ChangeLocationColumnName < ActiveRecord::Migration
  def change
  	rename_column :bus_stops, :location, :location_id 	
  	change_column :bus_stops, :location_id, :integer
  end
end
