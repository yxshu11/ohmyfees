class PaymentsController < ApplicationController

  def pay
    @student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])
    amount = (@student_fee.amount*100).round
    response = EXPRESS_GATEWAY.setup_purchase(amount,{
                                              :ip                   => request.remote_ip,
                                              :currency             => 'MYR',
                                              :return_url           => new_student_student_fee_payment_url,
                                              :cancel_return_url    => student_fees_url,
                                              :allow_guest_checkout => true,
                                              :no_shipping           => 1,
                                              :items                => [{
                                                                          :name => @student_fee.name,
                                                                          :description => @student_fee.description,
                                                                          :amount => amount,
                                                                       }]
                                              })
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def new
    @student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])
    @payment = current_user.payments.build(:express_token => params[:token])
  end

  def create
    student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])
    @payment = current_user.payments.build(ip: request.remote_ip,
                                           express_token: params[:express_token],
                                           student_fee_id: current_user.id)

    if @payment.purchase(student_fee.amount)
      @payment.save
      flash[:success] = "Payment Done Successfully"
      redirect_to student_fee
    else
      flash[:danger] = "Payment Unsuccesfull"
      redirect_to student_fee
    end
  end

  def index
  end

  def show
  end
end
