class MetroLine < ActiveRecord::Base
	require 'csv'
	has_many :metro_line_metro_stops, dependent: :destroy
	has_many :metro_stops, :through => :metro_line_metro_stops

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			MetroLine.create! row.to_hash
		end
	end
end
