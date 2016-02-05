class StatisticsController < ApplicationController
  before_action :logged_in_user, only: [:index, :student, :payment]
  before_action :staff_user_type, only: [:index, :student, :payment]

  def index

  end

  def student
    @students = Student
  end

  def payment
    @payments = Payment

    if params[:period].nil?
      params[:period] = "day"
    end

    if params[:period] == "day"
      date_format = "%d %b %Y"
    elsif params[:period] == "month"
      date_format = "%b %Y"
    elsif params[:period] == "week"
      date_format = "%d %b %Y"
    elsif params[:period] == "year"
      date_format = "%Y"
    end

    @chart = @payments.group_by_period(params[:period],
                                       :created_at,
                                       format: date_format,
                                       week_start: :mon,
                                       permit: %w[day month week year]).count
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def staff_user_type
      unless @current_user.type == "Staff"
        flash[:danger] = "Access Denied."
        redirect_to(root_path)
      end
  end

end
