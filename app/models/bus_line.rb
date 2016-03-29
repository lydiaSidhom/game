class BusLine < ActiveRecord::Base
	require 'csv'
	has_many :bus_line_bus_stops, dependent: :destroy
	has_many :bus_stops, :through => :bus_line_bus_stops

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			BusLine.create! row.to_hash
		end
	end
end
