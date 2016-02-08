class ChangeColumnName < ActiveRecord::Migration
	def self.up
	  rename_column :bus_stops, :location, :location_not_int
	  add_column :bus_stops, :location_id, :integer

	  BusStop.reset_column_information
	  BusStop.find_each { |b| b.update_attribute(:location_id, b.location_not_int) } 
	  remove_column :bus_stops, :location_not_int
	end
end
