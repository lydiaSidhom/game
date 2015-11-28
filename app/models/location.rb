class Location < ActiveRecord::Base
	has_many :bus_stops

	def self.search(term)
  		where('LOWER(name) LIKE :term', term: "%#{term.to_s.strip.downcase}%").limit(5)
	end
end
