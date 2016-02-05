class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by(email: params[:password_reset][:email].downcase)

    if user
      if user.type == "Student"
        @user = Student.find(user.id)
      elsif user.type == "Staff"
        @user = Staff.find(user.id)
      end

      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if password_blank?
      flash.now[:danger] = "Password can't be blank."
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      if @user.type == "Student"
        params.require(:student).permit(:password, :password_confirmation)
      elsif @user.type == "Staff"
        params.require(:staff).permit(:password, :password_confirmation)
      end

    end

    def password_blank?
      if @user.type == "Student"
        params[:student][:password].blank?
      elsif @user.type == "Staff"
        params[:staff][:password].blank?
      end
    end

    # Before filter

    def get_user
      user = User.find_by(email: params[:email])

      if user.type == "Student"
        @user = Student.find(user.id)
      elsif user.type == "Staff"
        @user = Staff.find(user.id)
      end
    end

    def valid_user
      # Staff no need to activate their account.
      unless (@user && (@user.type == "Staff" || @user.activated?) &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_path
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
