class LandingPagesController < ApplicationController
  # User access control
  before_action :logged_in_user, only: [:dashboard]

  def home
  end

  def help
  end

  def contact
  end

  def dashboard
    # @user = User.find(params[:id])
  end

  private
    # Before Filters for User access control.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end
end
