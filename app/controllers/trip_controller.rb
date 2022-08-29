class TripController < ApplicationController
  before_action :auth_user

  def index
    @trips = Trip.where(["user_id = ?", session[:user_id]]).page(params[:page] || 1).per_page(params[:per_page] || 10)

  end

  def new
    @trip = Trip.new
    @total = Destination.count
    @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
  end

  def create
    destination_ids = params[:destination_ids]
    if destination_ids == '' or !destination_ids
      flash[:notice] = "Create Trip Failed! Trip Destinations can`t be null, please choose your Destination Museums"
      @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
      @trip = Trip.new
      render action: :new
      return
    end

    @trip = current_user.trips.new(trip_attrs)
    destination_ids_array = destination_ids.split(',')
    destination_array = Destination.where(["id in (?)", destination_ids_array]).all
    city = nil
    t_type = 'day trip'
    n = 0
    destination_array.each do |des|
      if not city
        city = des.city
      elsif des.city != city or n >= 2
        t_type = 'multiple day trip'
        break
      end
      n += 1
    end
    @trip.trip_type = t_type

    if @trip.save

      destination_array.each do |d|
        @trip.destinations << d
      end
      flash[:notice] = "create trip succeed!"
      redirect_to trip_index_path
    else
      flash[:notice] = "create trip failed!"
      @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
      render action: :new
    end
  end

  def show
    @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
    @trip = Trip.find_by(id: params[:id])
    @d_ids = []
    @trip.destinations.each do |d|
      @d_ids << d.id
    end

  end

  def update

    destination_ids = params[:destination_ids]

    @trip = current_user.trips.find params[:id]
    puts @trip.to_json

    @trip.name = params[:trip][:name]
    @trip.trip_date = params[:trip][:trip_date]
    if destination_ids and destination_ids.strip != ''
      old_ids = []
      destination_ids_array = destination_ids.split(',')

      @trip.destinations.each do |d|
        old_ids << d.id
      end
      ids = destination_ids_array - old_ids
      del_ids = (destination_ids_array & old_ids) | old_ids
      if del_ids.size > 0
        Trip.find_by_sql("delete from destinations_trips where trip_id=#{params[:id]} and destination_id in (#{del_ids.join(',')})")
      end
    end

    destinations = Destination.where(["id in (?)", ids])
    city = nil
    t_type = 'day trip'
    n = 0
    destinations.each do |des|
      if not city
        city = des.city
      elsif des.city != city or n >= 2
        t_type = 'multiple day trip'
        break
      end
    end
    @trip.trip_type = t_type
    if @trip.save
      destinations.each do |d|
        @trip.destinations << d
      end
      redirect_to trip_index_path
    else
      flash[:notice] = "update trip failed!"
      @destinations = Destination.page(params[:page] || 1).per_page(params[:per_page] || 10)
      render action: :new
    end
  end

  def destroy
    t_id = params[:id]
    Trip.find_by_sql("delete from destinations_trips where trip_id=#{params[:id]}")
    Trip.delete(t_id)
    flash[:notice] = "delete trip succeed!"
    redirect_to trip_index_path
  end

  private
  def trip_attrs
    params.require(:trip).permit(:id, :name, :trip_date)
  end

end
