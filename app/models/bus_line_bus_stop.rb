class BusLineBusStop < ActiveRecord::Base
	belongs_to :bus_stop
  	belongs_to :bus_line
end
