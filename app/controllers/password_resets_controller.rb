class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @student = Student.find_by(email: params[:password_reset][:email].downcase)
    if @student
      @student.create_reset_digest
      @student.send_password_reset_email
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
    elsif @student.update_attribute(student_params)
      log_in @student
      flash[:success] = "Password has been reset."
      redirected_to @student
    else
      render 'edit'
    end
  end

  private

    def student_params
      params.require(:student).permit(:password, :password_confirmation)
    end

    def password_blank?
      params[:student][:password].blank?
    end

    # Before filter

    def get_user
      @student = Student.find_by(email: params[:email])
    end

    def valid_user
      unless (@student && @student.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_path
      end
    end

    def check_expiration
      if @student.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end
