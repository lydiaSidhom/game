class ChangeLocationColumnName < ActiveRecord::Migration
  #def change
  	#rename_column :bus_stops, :location, :location_id 	
  	#change_column :bus_stops, :location_id, :integer
  #end

  def change
  	rename_column :bus_stops, :location, :location_id 	
  	
  connection.execute(%q{
    alter table bus_stops
    alter column location_id
    type integer using cast(number as integer)
  })
  end
end
