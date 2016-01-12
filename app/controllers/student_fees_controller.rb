class StudentFeesController < ApplicationController

  def index
    if current_user_type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fees = current_user.student_fees.paginate(page: params[:page])
    elsif current_user_type == "Staff"
      # Display the all the fees in the system for the signed in staff.
      @student_fees = StudentFee.paginate(page: params[:page])
    end
  end

  def show
    if current_user_type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fee = current_user.student_fees.find(params[:id])
    elsif current_user_type == "Staff"
      # Display the all the fees in the system for the signed in staff.
      @student_fee = StudentFee.find(params[:id])
    end
  end

  def payment
    # To be implemented.
  end
end
