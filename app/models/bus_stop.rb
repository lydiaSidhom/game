class BusStop < ActiveRecord::Base
	has_many :bus_line_bus_stops, dependent: :destroy
	has_many :bus_lines, :through => :bus_line_bus_stops

	belongs_to :location

	reverse_geocoded_by :lat, :lng

#	def self.search(term)
#  		where('LOWER(name) LIKE :term', term: "%#{term.to_s.strip.downcase}%").limit(5)
#	end
end
