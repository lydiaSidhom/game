class BusLine < ActiveRecord::Base
	has_many :bus_line_bus_stops, dependent: :destroy
	has_many :bus_stops, :through => :bus_line_bus_stops
end
