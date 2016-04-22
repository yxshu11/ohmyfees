class ReportsController < ApplicationController
  before_action :logged_in_user, only: [:index, :monthly, :annual]
  before_action :staff_user_type, only: [:index, :monthly, :annual]

  def index

  end

  def monthly
    # Get the payment created_at data and group it into array,
    # to be used in the dropdown list for the user to select
    month_data = Payment.group_by_month(:created_at).count
    @monthly = Array.new
    month_data.each do |k,v|
      @monthly << k.strftime("%B %Y")
    end

    # Setting the params for the monthly period that selected by the user in the views
    if !@monthly.empty?
      if params[:monthly_period] == nil
        @monthly_period_range = "01" << @monthly.first
      else
        @monthly_period_range = "01 " << params[:monthly_period].first.to_s
      end

      # Convert the selected period into datetime format
      @monthly_period_range = @monthly_period_range.to_datetime

      # Fetch the data based on the selected period by the user
      monthly_data = Payment.where(created_at: @monthly_period_range.beginning_of_month..@monthly_period_range.end_of_month)
      # Putting the data into pagination
      @monthly_payment = monthly_data.paginate(page: params[:page], :per_page => 15)

      # Calculate the number of payment received (within the month selected by user)
      @mon_total_payments_received = monthly_data.count
      # Calculate the percentage of number of payment received of this month out of all
      @mon_total_payment_received_percentage = (@mon_total_payments_received.to_f/Payment.all.count) * 100

      # Calculate the total amount received (within the month selected by user)
      @mon_total_amount_received = monthly_data.sum(:amount)
      # Calculate the percentage of total amount received of this month out of all
      @mon_total_amount_received_percentage = (@mon_total_amount_received.to_f/Payment.sum(:amount)) * 100

      # Getting the data for the chart to show each day how many payment is made
      @mon_chart = monthly_data.group_by_day(:created_at).count

    end
  end

  def annual
    # Get the payment created_at data and group it into array,
    # to be used in the dropdown list for the user to select
    year_data = Payment.group_by_year(:created_at).count
    @annual = Array.new
    year_data.each do |k,v|
      @annual << k.strftime("%Y")
    end

    # Setting the params for the yearly period that selected by the user in the views
    if params[:annual_period] == nil
      @annual_period_range = "01/01/" << @annual.first
    else
      @annual_period_range = "01/01/" << params[:annual_period].first.to_s
    end
    # Convert the result into datetime format
    @annual_period_range = @annual_period_range.to_datetime

    # Fetch the data based on the selected period by the user
    annual_data = Payment.where(created_at: @annual_period_range.beginning_of_year..@annual_period_range.end_of_year)
    # Putting the data into pagination
    @annual_payment = annual_data.paginate(page: params[:page], :per_page => 15)

    # Calculate the number of payment received (within the year selected by user)
    @year_total_payment_received = annual_data.count
    # Calculate the percentage of number of payment received of this year out of all
    @year_total_payment_received_percentage = (@year_total_payment_received.to_f/Payment.all.count) * 100

    # Calculate the total amount received (within the year selected by user)
    @year_total_amount_received = annual_data.sum(:amount)
    # Calculate the percentage of total amount received of this year out of all
    @year_total_amount_received_percentage = (@year_total_amount_received.to_f/Payment.sum(:amount)) * 100

    # Getting the data for the chart to show each month how many payment is made
    @annual_chart = annual_data.group_by_month(:created_at).count
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
        redirect_to root_path
      end
    end
end
