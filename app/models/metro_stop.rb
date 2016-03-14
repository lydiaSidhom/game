class MetroStop < ActiveRecord::Base
	require 'csv'
	has_many :metro_line_metro_stops, dependent: :destroy
	has_many :metro_lines, :through => :metro_line_metro_stops

	belongs_to :location

	reverse_geocoded_by :lat, :lng

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			MetroStop.create! row.to_hash
		end
	end
end
