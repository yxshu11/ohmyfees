class StudentsController < ApplicationController
  # User access control
  before_action :logged_in_user, only: [:edit, :update, :show, :index]
  before_action :staff_user, only: [:index, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]

  # GET for students_path
  def index
    @students = Student.paginate(page: params[:page])
  end

  # GET for student_registration
  def new
    @student = Student.new
    @intakes = Intake.all
  end

  # POST for student_registration
  def create
    @student = Student.new(student_params)
    @intakes = Intake.all
    if @student.save
      # Student account is create, but activation needed.
      @student.send_activation_mail
      # Notify the student about the activation.
      flash[:info] = "One last step, please check your email to activate your account."
      # Meanwhile, redirect the student back to the homepage.
      redirect_to root_path
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

  # DELETE for destroy student
  def destroy
    Student.find(params[:id]).destroy
    flash[:success] = "Student account deleted."
    redirect_to students_path
  end

  private
    # Define the Strong Parameters (Params) for the student for security purpose in the views.
    def student_params
      params.require(:student).permit(:name, :student_number, :contact_number, :intake, :international,
                                      :picture, :tfa, :email, :password, :password_confirmation)
    end

    # Before Filters for User access control
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    # Confirms the correct user. (Staff is under exception)
    def correct_user
      if current_user.type == "Student"
        @student = Student.find_by(id: params[:id])
        unless current_user?(@student)
          flash[:danger] = "Access Denied."
          redirect_to(root_path)
        end
      end
    end

    # Confirms an Staff user.
    def staff_user
      unless current_user.type == "Staff"
        flash[:danger] = "Access Denied."
        redirect_to(root_path)
      end
    end

end
