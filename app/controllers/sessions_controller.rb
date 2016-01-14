class SessionsController < ApplicationController

  def new
  end

  def create
    # Get the student obj by searching the email
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log In and Handle something
      if @user.type == "Staff" || @user.activated?
        # If the user is activated!
        flash[:success] = "Log In Successfully!"
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or dashboard_path
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_path
      end
    else
      # Create an Error Message
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'
    end

  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "Log Out Sucessfully!"
    end
    redirect_to root_path
  end

end
