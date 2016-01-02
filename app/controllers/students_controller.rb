class StudentsController < ApplicationController

  def index
    @students = Student.paginate(page: params[:page])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      # Successfully Sign Up
      flash[:success] = "Sign Up Completed, Welcome to OHMYFEES!"
      redirect_to @student
    else
      # Handle Unsuccessful Sign Up
      render 'new'
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  private

    def student_params
      params.require(:student).permit(:name, :student_number, :intake, :email, :password, :password_confirmation)
    end
end
