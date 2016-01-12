class StudentFeesController < ApplicationController
  def index
    @student_fees = StudentFee.paginate(page: params[:page])
  end

  def show

  end

  def payment

  end
end
