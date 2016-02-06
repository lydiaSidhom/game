class Location < ActiveRecord::Base
	has_many :bus_stops

	has_many :start_locations, :class_name => "Errand", :foreign_key => "start_id"
  	has_many :end_locations, :class_name => "Errand", :foreign_key => "end_id"

	def self.search(term)
  		where('LOWER(name) LIKE :term', term: "%#{term.to_s.strip.downcase}%").limit(5)
	end
end
