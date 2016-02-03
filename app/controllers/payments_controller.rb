class PaymentsController < ApplicationController

  def pay
    @student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])

    fine = @student_fee.fines.all

    total_fine_amount = 0

    fine.each do |f|
      total_fine_amount = total_fine_amount + f.amount
    end

    amount = ((@student_fee.amount + total_fine_amount)*100).round
    
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
                                           student_fee_id: student_fee.id)

    if @payment.purchase(student_fee.amount)
      student_fee.update_attribute(:paid, true)
      @payment.save
      flash[:success] = "Payment Done Successfully"
      redirect_to student_fee
    else
      flash[:danger] = "Payment Unsuccesfull"
      redirect_to student_fee
    end
  end

  def index
    if current_user.type == "Student"
      @student_fee = current_user.student_fees.where("paid = ?", true).order(:updated_at)
      @payments = current_user.student_fees.where("paid = ?", true).paginate(page: params[:page]).order(:updated_at)
    else current_user.type == "Staff"
    end
  end

  def show
  end
end
