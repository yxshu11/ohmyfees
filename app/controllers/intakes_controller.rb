class IntakesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  before_action :correct_user_type, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  def new
    @intake = selected_programme.intakes.build
  end

  def create
    @intake = selected_programme.intakes.build(intake_params)
    if @intake.save
      flash[:success] = "Intake added!"
      redirect_to selected_programme
    else
      render 'new'
    end

  end

  def show
    # programme = Programme.find(params[:programme_id])
    @intake = Intake.find(params[:id])
  end

  def index
    @intakes = Intake.paginate(page: params[:page])
    # programme = Programme.find(params[:programme_id])
    # @intake = programme.intakes.paginate(page: params[:page])
  end

  def edit
    @intake = Intake.find(params[:id])
  end

  def update
    @intake = Intake.find(params[:id])
      if @intake.update_attributes(intake_params)
        flash[:success] = "Intake details updated."
        redirect_to @intake
      else
        render 'edit'
      end
  end

  def destroy
    @intake = Intake.find(params[:id]).destroy
    flash[:success] = "Selected Intake deleted."
    redirect_to intakes_path
  end

  private

    def intake_params
      params.require(:intake).permit(:intake_code, :starting_date, :local_student_fee, :international_student_fee)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def correct_user_type
      unless @current_user.type == "Staff"
        flash[:danger] = "Access Denied."
        redirect_to(root_path)
      end
    end
end
