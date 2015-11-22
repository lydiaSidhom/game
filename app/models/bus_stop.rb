class BusStop < ActiveRecord::Base
	acts_as_mappable defaults_units: :kms, lat_column_name: :lat, lng_column_name: :lng
	has_many :bus_line_bus_stops, dependent: :destroy
	has_many :bus_lines, :through => :bus_line_bus_stops

	def self.search(term)
  		where('LOWER(name) LIKE :term', term: "%#{term.to_s.strip.downcase}%").limit(5)
	end
end
