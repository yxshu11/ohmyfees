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
      if @user.type == "Staff" # If it's staff account
        if @user.admin == true || @authentication == true
          log_in @user
          flash[:success] = "Log In Successfully!"
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_back_or dashboard_path
        else
          flash[:warning] = "Please enable your service location and sign-in within specified location(s). Contact the administrator for information."
          render 'new'
        end
      else # @user.type == "Student" If it's student account
        if @user.activated? # If the student account is activated
          if @user.tfa == true # If the student turn on two factor authentication
            tfa_user @user
            redirect_to tfa_path
          else # If the student do not turn on tfa
            log_in @user
            flash[:success] = "Log In Successfully!"
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
    @user = User.find(tfa_user_id)

    @otpauth = @user.provisioning_uri(nil, issuer: 'OHMYFEES')

    @qr = RQRCode::QRCode.new(@otpauth).to_img.resize(250, 250).to_data_url

    if !params[:sms_otp].nil?
      client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
      client.messages.create(from: ENV["twi_from"],
                              to: ENV["twi_to"],
                              body: "OHMYFEES \nYour one time password (OHMYCode) is: #{@user.otp_code}. \nThank you.")
      flash.now[:success] = "OTP Code has been sent, please check your phone."
    end

    if !params[:otp_code].nil?
      otp_code = params[:otp_code]
      if @user.authenticate_otp(otp_code, drift: 60)
        log_in @user
        flash[:success] = "Log In Successfully!"
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
      flash[:success] = "Log Out Sucessfully!"
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
