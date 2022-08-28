class TripController < ApplicationController
  before_action :auth_user

  def index
    @trips = Trip.where(["user_id = ?", session[:user_id]]).page(params[:page] || 1).per_page(params[:per_page] || 10)
  end

  def new
    @trip = Trip.new
    @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
  end

  def create

    @trip = current_user.trips.new(trip_attrs)
    if @trip.save
      destination_ids = params[:destination_ids]
      destination_ids_array = destination_ids.split(',')
      destination_array = Destination.where(["id in (?)", destination_ids_array]).all
      destination_array.each do |d|
        @trip.destinations << d
        flash[:notice] = "create trip succeed!"
        redirect_to trip_path
      end
    else
      flash[:notice] = "create trip failed!"
      @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
      render action: :new
    end

  end

  def edit

  end

  private
  def trip_attrs
    params.require(:trip).permit(:name, :trip_date)
  end

end
