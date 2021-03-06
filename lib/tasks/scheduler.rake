desc "This task is called by the Heroku scheduler add-on"

task :check_due_fees => :environment do
  puts "Checking fees that going to be due"
  # Check the fees that going to be due.
  # Get the student fee that is not being paid and going to be due on 2 days
  # and the student fee have not been notify yet or have been notify since a week ago.
  studentFees = StudentFee.where(paid: false).where("due_date = ?", Date.today + 2.days).where("notify = ? OR notify IS NULL", Date.today - 7.days)

  # Group the student fees based on user id
  gsf = studentFees.group(:user_id).count

  # Separate each of the key and value of the hash of grouped student fees
  gsf.each do |sid,dp|
    s = Student.find_by(id: sid)
    sf = studentFees.where(user_id: sid)

    # If the due payment more than 1, sent a group SMS and email.
    if dp > 1
      # Send the email using mailer
      StudentMailer.due_payment(s, sf.first, dp).deliver_now
      puts "Mail sent"
      # Send the SMS using Twilio API
      client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
      client.messages.create(from: ENV["twi_from"],
                             to: ENV["twi_to"],
                             body: "OHMYFEES \nDear student, kindly be reminded that you are having #{dp} fees statement that going to be due soon. \nLogin to OHMYFEES for more information. Thank you.")
      puts "SMS sent"
      sf.each do |f|
        f.update_attribute(:notify, Date.today)
      end
    # Else sent the details information of the one specific due payment.
    else
      # Email the student about the payment is about to due soon.
      StudentMailer.due_payment(s, sf.first, dp).deliver_now
      puts "Mail sent"
      # SMS the student about the the payment is about to due soon.
      client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
      client.messages.create(from: ENV["twi_from"],
                              to: ENV["twi_to"],
                              body: "OHMYFEES \nDear student, kindly be reminded that you are having an fee payment that going to be due soon. \nName: #{sf.first.name} \nDescription: #{sf.first.description} \nAmount: RM #{sprintf('%.2f', sf.first.amount)} \nDue Date: #{sf.first.due_date} \nKindly make your payment as soon as possible. Thank you.")
      puts "SMS sent"
      sf.first.update_attribute(:notify, Date.today)
    end
  end
  puts "Task Done."
end

# Old Checking mechanism (Will sent the message for each single due fees)
# task :check_due_fees => :environment do
#   puts "Checking fees that going to be due..."
#   # Check the fees that going to be due.
#   StudentFee.all.each do |sf|
#     # If the fees' due date is less than 2 days,
#     # email the student and notify then about the payment.
#     if  sf.due_date.to_date - 2.days == Date.today && Payment.find_by(student_fee_id: sf.id).nil?
#       s = Student.find_by(id: sf.user_id)
#       if sf.notify == nil || sf.notify < DateTime.now - 5.days
#         # Email the student about the payment is about to due soon.
#         StudentMailer.due_payment(s, sf).deliver_now
#         puts "Mail sent"
#         # SMS the student about the the payment is about to due soon.
#         client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
# 				client.messages.create(from: ENV["twi_from"],
#                                 to: ENV["twi_to"],
#                                 body: "OHMYFEES \nDear student, kindly be reminded that you are having an fee payment that going to be due soon. \nName: #{sf.name} \nDescription: #{sf.description} \nAmount: RM #{sprintf('%.2f', sf.amount)} \nDue Date: #{sf.due_date} \nKindly make your payment as soon as possible. Thank you.")
#         sf.update_attribute(:notify, DateTime.now)
#       end
#     end
#   end
#   puts "Task done."
# end

task :check_outstanding_fees => :environment do
  puts "Checking the outstanding fees that have not been paid yet"
  # Check the outstanding fees for the students.
  # Get the student fee that is not being paid and due date is less than today
  # and the student fee have not been notify yet or have been notify since a week ago.
  studentFees = StudentFee.where(paid: false).where("due_date < ?", Date.today).where("notify = ? OR notify IS NULL", Date.today - 7.days)

  # Group the student fees based on user id
  gsf = studentFees.group(:user_id).count

  # Separate each of the key and value of the hash of grouped student fees
  gsf.each do |sid,dp|
    s = Student.find_by(id: sid)
    sf = studentFees.where(user_id: sid)

    # If the due payment more than 1, sent a grouped SMS and email.
    if dp > 1
      # Send the email using mailer
      StudentMailer.outstanding_payment(s, sf.first, dp).deliver_now
      puts "Mail sent"
      # Send the SMS using Twilio API
      client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
      client.messages.create(from: ENV["twi_from"],
                             to: ENV["twi_to"],
                             body: "OHMYFEES \nDear student, kindly be reminded that you are having #{dp} outstanding fees. \nLogin to OHMYFEES for more information. Thank you.")
      puts "SMS sent"
      sf.each do |f|
        f.update_attribute(:notify, Date.today)
      end
    # Else sent the details information of the one specific due payment.
    else
      # Email the student about having the outstanding payment.
      StudentMailer.due_payment(s, sf.first, dp).deliver_now
      puts "Mail sent"
      # SMS the student about having the outstanding payment.
      client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
      client.messages.create(from: ENV["twi_from"],
                              to: ENV["twi_to"],
                              body: "OHMYFEES \nDear student, kindly be reminded that you are having an outstanding fee. \nName: #{sf.first.name} \nDescription: #{sf.first.description} \nAmount: RM#{sprintf('%.2f', sf.first.amount)} \nDue Date: #{sf.first.due_date} \nKindly make your payment as soon as possible. Thank you.")
      puts "SMS sent"
      sf.first.update_attribute(:notify, Date.today)
    end
  end
  puts "Task Done."
end

# Old tast for checking outstanding fees
# task :check_outstanding_fees => :environment do
#   puts "Checking the outstanding fees that have not been paid yet..."
#   # Check the outstanding fees for the students.
#   StudentFee.all.each do |sf|
#     # If the payment is outstanding for a period of time, fine will be added based on the condition
#     if sf.due_date < DateTime.now && Payment.find_by(student_fee_id: sf.id).nil?
#       s = Student.find_by(id: sf.user_id)
#       if sf.notify == nil || sf.notify < DateTime.now - 5.days
#         # Email the student about the payment is about to due soon.
#         StudentMailer.outstanding_payment(s, sf).deliver_now
#         puts "Mail Sent"
#         # SMS the student about the the payment is about to due soon.
#         client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
# 				client.messages.create(from: ENV["twi_from"],
#                                 to: ENV["twi_to"],
#                                 body: "OHMYFEES \nDear student, kindly be reminded that you are having an outstanding fee. \nName: #{sf.name} \nDescription: #{sf.description} \nAmount: RM#{sprintf('%.2f', sf.amount)} \nDue Date: #{sf.due_date} \nKindly make your payment as soon as possible. Thank you.")
#         sf.update_attribute(:notify, DateTime.now)
#       end
#     end
#
#   end
#   puts "Task done."
# end

task :check_fine_fees => :environment do
  puts "Checking the fine that have not been paid yet..."

  # If the payment is outstanding for a period of time, fine will be added based on the condition
  studentFee = StudentFee.where(paid: false)

  studentFee.each do |sf|
    fine = Fine.where("student_fee_id = ?", sf.id)

    # If the due date of the student fees is exceed with 7 days grade period, add RM20 Fine
    if sf.due_date + 7.days < Date.today
      if fine.sum(:amount) < 20
        Fine.create!(name: "Late Payment Charges for " + sf.name,
                     amount: 20,
                     student_fee_id: sf.id)
        puts "Late Payment charges issued."
      end
    end

    # If the due date of the student fees is exceed with 21 days of grace period, add RM50 Fine
    if sf.due_date + 21.days < Date.today
      if fine.sum(:amount) < 70
        Fine.create!(name: "Administrative Fees for " + sf.name,
                     amount: 50,
                     student_fee_id: sf.id)
        puts "Administrative Fees charges issued."
      else
        puts "Maximum fine reached."
      end
    end
  end
  puts "Task done."
end

# Old Student Fine Fees codes
# StudentFee.all.each do |sf|
#   # If the payment is outstanding for a period of time, fine will be added based on the condition
#   if sf.due_date + 7.days < Date.today && sf.paid == false
#     fine = Fine.where("student_fee_id = ?", sf.id)
#     if fine.empty?
#       Fine.create!(name: "Late Payment Charges for " + sf.name,
#                    amount: 20,
#                    student_fee_id: sf.id)
#     else
#       if fine.order(created_at: :desc).first.created_at + 7.days < Date.today
#         total_amount = 0
#
#         fine.each do |f|
#           total_amount = total_amount + f.amount
#         end
#
#         puts total_amount
#
#         if total_amount < 70
#           Fine.create!(name: "Administrative Fees for " + sf.name,
#                        amount: 50,
#                        student_fee_id: sf.id)
#         else
#           puts "Maximum fine reached!"
#         end
#       end
#     end
#   end
# end
# puts "Task done."
# end
