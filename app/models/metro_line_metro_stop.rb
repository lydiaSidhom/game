class MetroLineMetroStop < ActiveRecord::Base
	require 'csv'
	belongs_to :metro_stop
  	belongs_to :metro_line

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			MetroLineMetroStop.create! row.to_hash
		end
	end
end
