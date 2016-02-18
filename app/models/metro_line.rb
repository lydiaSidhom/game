class MetroLine < ActiveRecord::Base
	has_many :metro_line_metro_stops, dependent: :destroy
	has_many :metro_stops, :through => :metro_line_metro_stops
end
