class MetroLinesController < ApplicationController
  def index
  	@metro_lines = MetroLine.all
  end

  def import
  	MetroLine.import(params[:file])
  	redirect_to root_url, notice: "Done"
  end
end
