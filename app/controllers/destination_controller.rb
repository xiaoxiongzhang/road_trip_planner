class DestinationController < ApplicationController

  def list
    @page = params[:page].to_i
    offset = @page - 1
    @limit = params[:size]
    @destinations = Destination.offset(offset).limit(@limit).all
    @total = Destination.count
    render json: {
      'data': @destinations,
      'page': @page,
      'total': @total
    }
  end

  def search
    if params[:name].strip != ''
      @destinations = Destination.where(["name like ?", "%#{params[:name]}%"]).page(params[:page] || 1).per_page(params[:per_page] || 10)
      puts @destinations

    else
      @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
    end
    render action: :index
  end

  def index
    @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
  end

end
