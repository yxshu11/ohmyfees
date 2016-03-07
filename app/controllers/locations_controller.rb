class LocationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  before_action :correct_user_type, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = "Location saved successfully."
      redirect_to locations_path
    else
      render 'new'
    end
  end

  def index
    @locations = Location.paginate(page: params[:page])
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      flash[:success] = "Location updated successfully."
      redirect_to @location
    else
      render 'edit'
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def destroy
    Location.find(params[:id]).destroy
    flash[:success] = "Location removed successfully."
    redirect_to locations_path
  end

  private

    def location_params
      params.require(:location).permit(:name, :latitude, :longitude)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def correct_user_type
      unless @current_user.type == "Staff" && @current_user.admin == true
        flash[:danger] = "Access Denied."
        redirect_to(root_path)
      end
    end
end
