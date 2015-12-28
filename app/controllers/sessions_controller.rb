class SessionsController < ApplicationController

  def new

  end

  def create
    # Get the student obj by searching the email
    if params[:type] == 'Student'
      # Fetch user from the Student Model
      user = Student.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        # Log In and Handle something
        log_in user
        redirect_to user
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
