class StaffsController < ApplicationController

  def index
    @staffs = Staff.paginate(page: params[:page])
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)
    if @staff.save
      # Successfully Sign Up
      flash.now[:success] = "Staff Profile Added!"
      redirect_to staffs_path
    else
      # Handle Unsuccessful Sign Up
      render 'new'
    end
  end

  def show
    @staff = Staff.find_by(params[:id])
  end

  private

    def staff_params
      params.require(:staff).permit(:name, :staff_number, :contact_number, :email,
                                      :password, :password_confirmation)
    end
end
