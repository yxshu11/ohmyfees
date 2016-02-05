class StatisticsController < ApplicationController

  def index

  end

  def student
    @students = Student
  end

  def payment
    @payments = Payment
  end

end
