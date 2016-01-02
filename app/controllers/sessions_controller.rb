class SessionsController < ApplicationController

  def new
  end

  def create
    # Get the student obj by searching the email
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log In and Handle something
      flash[:success] = "Log In Successfully!"
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to root_path
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
