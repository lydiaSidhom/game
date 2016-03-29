class BusLinesController < ApplicationController
  def index
  	@bus_lines = BusLine.all
  end

  def import
  	BusLine.import(params[:file])
  	redirect_to root_url, notice: "Done"
  end
end
