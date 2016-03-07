class SessionsController < ApplicationController
  # before_action :logged_in? only: [:new, :create]
  def new
  end

  def create
    # Get the Location Coordinate through cookies set by the jquery
    @user_location = cookies[:location_coordinate].try(:split, "|")
    # Set the Cookies for :location_coordinate back to nil for next user to use
    cookies[:location_coordinate] = nil

    locations = Location.all

    distance = Array.new
    locations.each do |loc|
      location_coordinate = Array.new
      location_coordinate << loc.latitude
      location_coordinate << loc.longitude
      distance << Geocoder::Calculations.distance_between(@user_location, location_coordinate)
    end

    @authentication = false

    if !distance.blank?
      distance.each do |d|
        # Set the difference of the distance between user and sign in location
        if d < 0.1
          @authentication = true
        end
      end
    end

    # Get the student obj by searching the email
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log In and Handle something
      if @user.type == "Staff" || @user.activated?
        # If the user is activated!
        if @user.admin == true || @authentication == true || @user.type == "Student"
          log_in @user
          flash[:success] = "Log In Successfully!"
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_back_or dashboard_path
        else
          flash[:warning] = "Please enable your service location and sign-in within specified location(s). Contact the administrator for information."
          render 'new'
        end

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
