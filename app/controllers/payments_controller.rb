class PaymentsController < ApplicationController

  def pay
    @student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])
    amount = (@student_fee.amount*100).round
    response = EXPRESS_GATEWAY.setup_purchase(amount,{
                                              :ip                   => request.remote_ip,
                                              :currency             => 'MYR',
                                              :return_url           => student_fees_url,
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
    # @payment = @student_fee.payment.build(:express_token => params[:token])
  end

  def create
    student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])
    @payment = student_fee.payment.build(payment_params)
    @payment.ip = request.remote_ip

    if response.success?
      flash[:success] = "Your transaction was successfully completed"
    else
      flash[:error] = "Your transaction could not be compelted"
    end

    if @payment.save
      flash[:notice] = "Payment Done Successfully"
      redirect_to violation_url(@violation)
    else
      flash[:notice] = "Payment Unsuccesfull"
      render :action => 'new'
    end
  end

  def index
  end

  def show
  end
end
