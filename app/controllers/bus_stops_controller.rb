class BusStopsController < ApplicationController
  def index
  	@bus_stops = BusStop.all
  end

  def import
  	BusStop.import(params[:file])
  	redirect_to root_url, notice: "Done"
  end
end
