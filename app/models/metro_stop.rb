class MetroStop < ActiveRecord::Base
	has_many :metro_line_metro_stops, dependent: :destroy
	has_many :metro_lines, :through => :metro_line_metro_stops

	belongs_to :location

	reverse_geocoded_by :lat, :lng
end
