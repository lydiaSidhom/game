class Errand < ActiveRecord::Base
	belongs_to :user
	#belongs_to :start, :class_name => "Location"
  	#belongs_to :end, :class_name => "Location"
end
