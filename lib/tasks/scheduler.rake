desc "This task is called by the Heroku scheduler add-on"
task :check_due_fees => :environment do
  puts "Checking fees that going to be due..."
  # Check the fees that going to be due.
  StudentFee.all.each do |sf|
    # If the fees' due date is less than 2 days,
    # email the student and notify then about the payment.
    if  sf.due_date < DateTime.now - 1.days && Payment.find_by(student_fee_id: sf.id).nil?
      s = Student.find_by(id: sf.user_id)
      if sf.notify == nil || sf.notify > DateTime.now + 5.days
        # Email the student about the payment is about to due soon.
        StudentMailer.due_payment(s, sf).deliver_now
        puts "Mail sent"
        # SMS the student about the the payment is about to due soon.
        sf.update_attribute(:notify, DateTime.now)
      end
    end
  end
  puts "Task done."
end

task :check_outstanding_fees => :environment do
  puts "Checking the outstanding fees that have not been paid yet..."
  # Check the outstanding fees for the students.
  StudentFee.all.each do |sf|
    # If the payment is outstanding for a period of time, fine will be added based on the condition
    if sf.due_date < DateTime.now && Payment.find_by(student_fee_id: sf.id).nil?
      s = Student.find_by(id: sf.user_id)
      if sf.notify == nil || sf.notify > DateTime.now + 5.days
        # Email the student about the payment is about to due soon.
        StudentMailer.outstanding_payment(s, sf).deliver_now
        # SMS the student about the the payment is about to due soon.
        sf.update_attribute(notify: DateTime.now)
      end
    end

  end
  puts "Task done."
end

task :check_fine_fees => :environment do
  puts "Checking the fine that have not been paid yet..."

  StudentFee.all.each do |sf|
    # If the payment is outstanding for a period of time, fine will be added based on the condition
    if sf.due_date + 7.days < DateTime.now && Payment.find_by(student_fee_id: sf.id).nil?
      fine = Fine.where("student_fee_id = ?", sf.id)
      if fine.empty?
        Fine.create!(name: "Fine for " + sf.name,
                     amount: 20,
                     student_fee_id: sf.id)
      else
        if fine.order(created_at: :desc).first.created_at + 7.days < DateTime.now
          total_amount = 0

          fine.each do |f|
            total_amount = total_amount + f.amount
          end
          puts total_amount

          if total_amount < 60
            Fine.create!(name: "Fine for " + sf.name,
                         amount: 20,
                         student_fee_id: sf.id)
          elsif total_amount == 60
            Fine.create!(name: "Fine for " + sf.name,
                         amount: 10,
                         student_fee_id: sf.id)
          else
            puts "Maximum fine reached!"
          end
        end
      end
    end
  end
  puts "Task done."
end
