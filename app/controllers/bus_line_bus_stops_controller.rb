class BusLineBusStopsController < ApplicationController
  def index
  	@bus_line_bus_stops = BusLineBusStop.all
  end

  def import
  	BusLineBusStop.import(params[:file])
  	redirect_to root_url, notice: "Done"
  end
end
