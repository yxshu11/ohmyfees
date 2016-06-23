class SessionsController < ApplicationController
  before_action :always_clear_tfa, except: [:create, :tfa]
  before_action :already_logged_in, except: [:destroy]
  before_action :check_logged_in_tfa, only: [:tfa]

  def new

  end

  def create
    # Get the Location Coordinate through cookies set by the jquery
    @user_location = cookies[:location_coordinate].try(:split, "|")
    # Set the Cookies for :location_coordinate back to nil for next user to use
    cookies[:location_coordinate] = nil

    locations = Location.all

    # Create an array to store all the compared distance
    distance = Array.new
    locations.each do |loc|
      location_coordinate = Array.new
      location_coordinate << loc.latitude
      location_coordinate << loc.longitude
      # Compare each of the location coordinate with the device location
      distance << Geocoder::Calculations.distance_between(@user_location, location_coordinate)
    end

    # By default the authentication of the location is set to false
    @authentication = false

    # Check the value of distance, if any of the distance is less than 100 meter,
    # the authentication will be set to true.
    if !distance.blank?
      distance.each do |d|
        # Set the difference of the distance between user and sign in location
        if d < 0.1
          @authentication = true
        end
      end
    end

    # Get the user obj by searching the email
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.type == "Staff" # If it's staff account
        # If it is admin account or the location condition is matched,
        # sign the user in.
        if @user.admin == true || @authentication == true
          log_in @user
          flash[:success] = "Log in successfully!"
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_back_or dashboard_path
        else
          flash.now[:warning] = "Please enable your service location and sign-in within specified location(s). Contact the administrator for information."
          render 'new'
        end
      else # @user.type == "Student" If it's student account
        if @user.activated? # If the student account is activated
          if @user.tfa == true # If the student turn on two factor authentication
            tfa_user @user
            redirect_to tfa_path
          else # If the student do not turn on tfa
            log_in @user
            flash[:success] = "Log in successfully!"
            params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
            redirect_back_or dashboard_path
          end
        else # If the student account is not activated
          message = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_path
        end
      end
    else
      # Create an Error Message
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def tfa
    # Obtain the user ID  that has passed the password authenticationfrom the session
    @user = User.find_by(id: tfa_user_id)

    #Obtain the OTP authentication URL from the user model
    @otpauth = @user.provisioning_uri(nil, issuer: 'OHMYFEES')

    #Generate the QR for dispalying on the views
    @qr = RQRCode::QRCode.new(@otpauth).to_img.resize(200, 200).to_data_url

    # Send the SMS that contains OTP to the student when request through SMS
    if !params[:sms_otp].nil?
      message = "OHMYFEES \nYour one time password (OTP) is: #{@user.otp_code}. \nThank you."
      send_message message
      flash.now[:success] = "OTP Code has been sent, please check your phone."
    end

    if !params[:otp_code].nil?
      # Get the OTP Code from the form that entered by the student
      otp_code = params[:otp_code]
      # Authenticate the OTP code (Given 60 seconds of timeframe)
      if @user.authenticate_otp(otp_code, drift: 60)
        # If OTP Code valid, sign user in, else display error message
        log_in @user
        flash[:success] = "Log in successfully!"
        redirect_back_or dashboard_path
      else
        flash.now[:danger] = "Invalid OTP Code. Please try again."
        render 'tfa'
      end
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "Log out sucessfully!"
    end
    redirect_to root_path
  end

  private

    def already_logged_in
      if logged_in?
        flash[:warning] = "You have already logged in."
        redirect_to dashboard_path
      end
    end

    def check_logged_in_tfa
      if tfa_user_id.nil?
        flash[:warning] = "Please log in."
        redirect_to login_path
      end
    end

    def always_clear_tfa
      clear_tfa
    end

end
