class StudentFeesController < ApplicationController

  def index
    if current_user_type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fees = current_user.student_fees.where("paid = ?", false).paginate(page: params[:page]).order(:due_date)
      @recent_fees = current_user.student_fees.where("due_date < ? AND paid = ?", DateTime.now + 1.month, false).order(:due_date)
      @outstanding_fees = current_user.student_fees.where("due_date < ? AND paid = ?", DateTime.now, false).order(:due_date)

    elsif current_user_type == "Staff"
      # Display the all the fees in the system for the signed in staff.
      @student_fees = StudentFee.paginate(page: params[:page])
    end
  end

  def show
    if current_user_type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fee = current_user.student_fees.find(params[:id])

      @fine = @student_fee.fines.all

      @total_fine_amount = @student_fee.fines.sum(:amount)

    elsif current_user_type == "Staff"
      # Display the all the fees in the system for the signed in staff.
      @student_fee = StudentFee.find(params[:id])
    end
  end
end
