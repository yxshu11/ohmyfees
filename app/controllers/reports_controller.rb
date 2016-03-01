class ReportsController < ApplicationController

  def index

  end

  def monthly
    month_data = Payment.group_by_month(:created_at).count

    @monthly = Array.new

    month_data.each do |k,v|
      @monthly << k.strftime("%B %Y")
    end

    if params[:monthly_period] == nil
      @monthly_period_range = "01" << @monthly.first
    else
      @monthly_period_range = "01 " << params[:monthly_period].first.to_s
    end

    @monthly_period_range = @monthly_period_range.to_datetime

    monthly_data = Payment.where(created_at: @monthly_period_range.beginning_of_month..@monthly_period_range.end_of_month)
    @monthly_payment = monthly_data.paginate(page: params[:page], :per_page => 15)

    @mon_total_amount_received = 0
    @mon_total_payments_received = monthly_data.count

    @mon_chart = monthly_data.group_by_day(:created_at).count

    monthly_data.each do |payment|
      @mon_total_amount_received = @mon_total_amount_received + payment.amount.to_i
    end
  end

  def annual
    year_data = Payment.group_by_year(:created_at).count

    @annual = Array.new

    year_data.each do |k,v|
      @annual << k.strftime("%Y")
    end

    if params[:annual_period] == nil
      @annual_period_range = "01/01/" << @annual.first
    else
      @annual_period_range = "01/01/" << params[:annual_period].first.to_s
    end

    @annual_period_range = @annual_period_range.to_datetime

    annual_data = Payment.where(created_at: @annual_period_range.beginning_of_year..@annual_period_range.end_of_year)
    @annual_payment = annual_data.paginate(page: params[:page], :per_page => 15)

    @annual_chart = annual_data.group_by_month(:created_at).count

    @year_total_amount_received = 0
    @year_total_payments_received = annual_data.count
    annual_data.each do |payment|
      @year_total_amount_received = @year_total_amount_received + payment.amount.to_i
    end
  end

end
