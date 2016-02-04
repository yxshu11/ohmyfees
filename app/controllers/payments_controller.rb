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
    if current_user.type == "Student"
      @student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])
      @payment = current_user.payments.build(:express_token => params[:token])
    elsif current_user.type == "Staff"
      @student_fee = StudentFee.find_by(id: params[:student_fee_id])
      @current_student = Student.find(@student_fee.user_id)
      @payment = Payment.new
    end
  end

  def create
    if current_user.type == "Student"
      student_fee = current_user.student_fees.find_by(id: params[:student_fee_id])
      fine_amount = student_fee.fines.sum(:amount)
      total_amount = student_fee.amount + fine_amount
      @payment = current_user.payments.build(ip: request.remote_ip,
                                             express_token: params[:express_token],
                                             student_fee_id: student_fee.id,
                                             paid_by: "Student",
                                             amount: total_amount,
                                             payment_method: "Online")

      if @payment.purchase(total_amount)
        student_fee.update_attribute(:paid, true)
        @payment.save
        flash[:success] = "Payment Done Successfully"
        redirect_to student_fee
      else
        flash[:danger] = "Payment Unsuccesfull"
        redirect_to student_fee
      end
    elsif current_user.type == "Staff"
      student_fee = StudentFee.find(params[:student_fee_id])
      fine_amount = student_fee.fines.sum(:amount)
      total_amount = student_fee.amount + fine_amount
      Payment.create!(paid_by: "Staff",
                      student_fee_id: student_fee.id,
                      amount: total_amount,
                      payment_method: params[:payment_method])
      student_fee.update_attribute(:paid, true)
      flash[:success] = "Payment Done Successfully"
      redirect_to dashboard_path
    end
  end

  def index
    if current_user.type == "Student"
      @student_fee = current_user.student_fees.where("paid = ?", true).order(:updated_at)
      @payments = current_user.student_fees.where("paid = ?", true).paginate(page: params[:page]).order(:updated_at)
    else current_user.type == "Staff"
      # To be implemented
    end
  end

  def show
    @student_fee = current_user.student_fees.find(params[:student_fee_id])
    @payment = @student_fee.payment
  end
end
