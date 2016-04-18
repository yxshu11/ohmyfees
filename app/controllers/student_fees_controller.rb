class StudentFeesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :correct_student, only: [:show]

  def index
    if current_user.type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fees = current_user.student_fees.where("paid = ?", false).paginate(page: params[:page]).order(:due_date)
      @recent_fees = current_user.student_fees.where("due_date < ? AND paid = ?", Date.today + 1.month, false).order(:due_date)
      @outstanding_fees = current_user.student_fees.where("due_date < ? AND paid = ?", Date.today, false).order(:due_date)

    elsif current_user.type == "Staff"
      # Display the all the fees in the system for the signed in staff.
      if params[:search]
        @student = Student.find_by(student_number: params[:search])
        if !(@student.nil?)
          @searched_student_fee = StudentFee.where(user_id: @student.id, paid: false).order(:due_date)
        end
      else
        @student_fees = StudentFee.paginate(page: params[:page])
      end
    end
  end

  def show
    if current_user.type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fee = current_user.student_fees.find(params[:id])

      @fine = @student_fee.fines.all

      @total_fine_amount = @student_fee.fines.sum(:amount)

    elsif current_user.type == "Staff"
      # Display the all the fees in the system for the signed in staff.
      @student_fee = StudentFee.find_by(id: params[:id])
      @current_student = Student.find_by(id: @student_fee.user_id)
      @fine = @student_fee.fines.all
      @total_fine_amount = @student_fee.fines.sum(:amount)
    end
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def correct_student
      if current_user.type == "Student"
        student_fee = StudentFee.find(params[:id])
        @student = Student.find_by(id: student_fee.user_id)
        unless current_user?(@student)
          flash[:danger] = "Access Denied."
          redirect_to(dashboard_path)
        end
      end
    end
end
