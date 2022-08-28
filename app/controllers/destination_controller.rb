class DestinationController < ApplicationController

  def index
    @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
  end


end
