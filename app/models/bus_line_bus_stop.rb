class BusLineBusStop < ActiveRecord::Base
	require 'csv'
	belongs_to :bus_stop
  	belongs_to :bus_line

  	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			BusLineBusStop.create! row.to_hash
		end
	end
end
