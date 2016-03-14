class MetroStopsController < ApplicationController
  def index
  	@metro_stops = MetroStop.all
  end

  def import
  	MetroStop.import(params[:file])
  	redirect_to root_url, notice: "Done"
  end
end
