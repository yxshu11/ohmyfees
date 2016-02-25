class StatisticsController < ApplicationController
  before_action :logged_in_user, only: [:index, :student, :payment]
  before_action :staff_user_type, only: [:index, :student, :payment]

  def index

  end

  def student
    # Get the year range from the student of creation year
    data = Student.group_by_year(:created_at).count

    @year = Array.new
    data.each do |k,v|
      @year << k.strftime("%Y")
    end

    # Set the params and and convert the string into date time format
    if params[:intake_year] == nil
      intake_year_range = "01/01/2016"
    else
      intake_year_range = "01/01/" << params[:intake_year].first.to_s
    end

    intake_year_range = intake_year_range.to_datetime

    if params[:programme_year] == nil
      programme_year_range = "01/01/2016"
    else
      programme_year_range = "01/01/" << params[:programme_year].first.to_s
    end

    programme_year_range = programme_year_range.to_datetime

    if params[:student_year] == nil
      student_year_range = "01/01/2016"
    else
      student_year_range = "01/01/" << params[:student_year].first.to_s
    end

    student_year_range = student_year_range.to_datetime

    # Data for Number of student based on intake
    intake_students = Student.where(created_at: intake_year_range.beginning_of_year..intake_year_range.end_of_year)
    @intake_chart = intake_students.group(:intake).count

    # Data for Number of student based on programme
    @programme_chart = Hash.new ()
    key = Array.new
    value = Array.new

    Programme.all.each do |programme|
      key << programme.name
      total_of_student = 0
      intake = Intake.where(programme_id: programme.id)
      intake.each do |i|
        total_of_student = total_of_student + Student.where(intake: i.intake_code,
                                                            created_at: programme_year_range.beginning_of_year..
                                                            programme_year_range.end_of_year).count
      end

      value << total_of_student
    end

    for i in 0..key.length-1 do
      @programme_chart[key.at(i)] = value.at(i)
    end

    # Data for Number of student based on that year
    year_students = Student.where(created_at: student_year_range.beginning_of_year..student_year_range.end_of_year)
    @year_chart = year_students.group_by_month(:created_at,
                                               format: "%b %Y").count
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
