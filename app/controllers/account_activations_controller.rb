class AccountActivationsController < ApplicationController

  def edit
    student = Student.find_by(email: params[:email])
    if student && !student.activated? && student.authenticated?(:activation, params[:id])
      student.activate
      log_in student
      flash[:success] = "Account Activated!"
      redirect_to student
    else
      flash[:danger] = "Invalid activation link!"
      redirect_to root_path
    end
  end
end
