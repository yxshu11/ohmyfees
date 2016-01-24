class PaymentsController < ApplicationController

  def new
    if current_user_type == "Student"
      # Display the fees that belong only the to the signed in student
      @student_fee = current_user.student_fees.find_by(id: params[:student_id])
      # @payment = current_user.payments.build

    elsif current_user_type == "Staff"
      # For staff to help student to pay.
      # To be implemented
    end
  end

  def create
    student = Student.find(params[:student_id])
    # Validation for the credit card details
    if credit_card.validate.empty?
      # Send the request to the payment gateway
      response = gateway.purchase(amount, credit_card)
      # Determine the response of the request is success or not
      if response.success?
        # Handle the success payment
        @payment = student.student_fee.payment.build()
      else
        # Handle the unsucessful payment method
        render 'new'
      end
    end

  end

  def index
  end

  def show
  end
end
