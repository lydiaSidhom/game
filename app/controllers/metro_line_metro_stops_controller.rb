class MetroLineMetroStopsController < ApplicationController
  def index
  	@metro_line_metro_stops = MetroLineMetroStop.all
  end

  def import
  	MetroLineMetroStop.import(params[:file])
  	redirect_to root_url, notice: "Done"
  end
end
