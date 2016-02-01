class LandingPagesController < ApplicationController
  # User access control
  before_action :logged_in_user, only: [:dashboard]

  def home

  end

  def help

  end

  def contact

  end

  def dashboard
    if current_user_type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fees = current_user.student_fees.where("due_date < ? AND paid = ?", DateTime.now + 1.month, false).order(:due_date)
    end
  end

  private
    # Before Filters for User access control.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end
end
