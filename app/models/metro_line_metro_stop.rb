class MetroLineMetroStop < ActiveRecord::Base
	belongs_to :metro_stop
  	belongs_to :metro_line
end
