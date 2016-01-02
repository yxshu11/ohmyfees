class StudentsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index]
  before_action :correct_user, only: [:edit, :update]

  # GET for students_path
  def index
    @students = Student.paginate(page: params[:page])
  end

  # GET for student_registration
  def new
    @student = Student.new
  end

  # POST for student_registration
  def create
    @student = Student.new(student_params)
    if @student.save
      # Successfully Sign Up
      log_in @student
      flash[:success] = "Sign Up Completed, Welcome to OHMYFEES!"
      redirect_to @student
    else
      # Handle Unsuccessful Sign Up
      render 'new'
    end
  end

  # GET for @student
  def show
    @student = Student.find(params[:id])
  end

  # GET for edit_student_path
  def edit
    @student = Student.find(params[:id])
  end

  # POST for edit_student_path
  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params)
      # Sucessfully Edit
      flash[:success] = "Profile Updated!"
      redirect_to @student
    else
      # Unsuccessful Edit
      render 'edit'
    end
  end

  private
    # Define the Params for the student for security purpose.
    def student_params
      params.require(:student).permit(:name, :student_number, :contact_number, :intake, :email,
                                      :password, :password_confirmation)
    end

    # Before Filters
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end
    # Confirms the correct user.
    def correct_user
      @student = Student.find(params[:id])
      redirect_to(root_path) unless current_user?(@student)
    end
end
