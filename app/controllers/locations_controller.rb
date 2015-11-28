class LocationsController < ApplicationController
	def search
	    respond_to do |format|
	      format.html
	      format.json { @locations = Location.search(params[:term]) }
	    end
	end
end
