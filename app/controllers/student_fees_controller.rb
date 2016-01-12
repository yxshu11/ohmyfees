class StudentFeesController < ApplicationController
  def index
    @student_fees = StudentFee.paginate(page: params[:page])
  end

  def show
    @student_fee = StudentFee.find(params[:id])
  end

  def payment
    # To be implemented.
  end
end
