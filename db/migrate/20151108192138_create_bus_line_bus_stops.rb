class CreateBusLineBusStops < ActiveRecord::Migration
  def change
    create_table :bus_line_bus_stops do |t|
    	t.integer :bus_line_id
     	t.integer :bus_stop_id
    end
  end
end
