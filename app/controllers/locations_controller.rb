class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = "Location saved successfully."
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def index
    @locations = Location.paginate(page: params[:page])
  end

  def show
    @location = Location.find(params[:id])
    @my_location_ip = request.location.city
    # @places.nearby(@location.latitude, @location.longitude)
  end

  def destroy
    Location.find(params[:id]).destory
    flash[:success] = "Location removed successfully."
    redirect_to locations_path
  end

  private

    def location_params
      params.require(:location).permit(:name, :latitude, :longitude)
    end
end
