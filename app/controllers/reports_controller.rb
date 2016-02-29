class ReportsController < ApplicationController

  def show
    @payments = Payment.paginate(page: params[:page])

    @total = 0

    @total_payments_received = Payment.count
    @payments.each do |payment|
      @total = @total + payment.amount.to_i
    end
  end
end
