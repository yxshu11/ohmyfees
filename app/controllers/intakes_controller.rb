class IntakesController < ApplicationController

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
    # @intake = Intake.find(params[:id])

  end

  def destroy
    # @intake = Intake.find(params[:id]).destroy

  end

  private

    def intake_params
      params.require(:intake).permit(:intake_code, :starting_date, :local_student_fee, :international_student_fee)
    end
end
