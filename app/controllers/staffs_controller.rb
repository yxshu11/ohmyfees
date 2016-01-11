class StaffsController < ApplicationController
  # User access control
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :show, :index, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:new, :create, :index, :destroy]

  # GET for staffs_path
  def index
    @staffs = Staff.paginate(page: params[:page])
  end

  # GET for staff_registration
  def new
    @staff = Staff.new
  end

  # POST for staff_registration
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

  # GET for @staff
  def show
    @staff = Staff.find(params[:id])
  end

  # GET for edit_staff_path
  def edit
    @staff = Staff.find(params[:id])
  end

  # POST for edit_staff_path
  def update
    @staff = Staff.find(params[:id])
    if @staff.update_attributes(staff_params)
      # Successfully edit
      flash[:success] = "Profile Update!"
      redirect_to @staff
    else
      # Unsuccessful Edit
      render 'edit'
    end
  end

  # DELETE for destroy staff Account
  def destroy
    Staff.find(params[:id]).destroy
    flash[:sucess] = "Staff account deleted."
    redirect_to staffs_path
  end

  private

    # Define the strog parameters (params) for the staff account for security purpose in the views
    def staff_params
      params.require(:staff).permit(:name, :staff_number, :contact_number, :email,
                                      :password, :password_confirmation)
    end

    # Before Filters for User access control.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    # Confirms the correct user.
    def correct_user
      @staff = Staff.find(params[:id])
      unless current_user?(@staff)
        flash[:danger] = "Access Denied."
        redirect_to(root_path)
      end
    end

    # Confirms an admin user.
    def admin_user
      unless current_user.admin?
        flash[:danger] = "Acess Denied."
        redirect_to(root_path)
      end
    end
end
