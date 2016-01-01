class SessionsController < ApplicationController

  def new

  end

  def create
    # Get the student obj by searching the email
    if params[:type] == 'Student'
      # Fetch user from the Student Model
      student = Student.find_by(email: params[:session][:email].downcase)
      if student && student.authenticate(params[:session][:password])
        # Log In and Handle something
        flash[:success] = "Log In Successfully!"
        log_in student,params[:type]
        redirect_to student
      else
        # Create an Error Message
        flash.now[:danger] = 'Invalid email/password combination.'
        render 'new'
      end
    elsif params[:type] == 'Staff'
      # Fetch user from the Staff Model
    else
      flash.now[:danger] = 'Please select User Type!'
      render 'new'
    end

  end

  def destroy

  end

end
