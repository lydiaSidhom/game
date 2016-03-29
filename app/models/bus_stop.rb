class BusStop < ActiveRecord::Base
	require 'csv'
	has_many :bus_line_bus_stops, dependent: :destroy
	has_many :bus_lines, :through => :bus_line_bus_stops

	belongs_to :location

	reverse_geocoded_by :lat, :lng

  	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			BusStop.create! row.to_hash
		end
	end
end
