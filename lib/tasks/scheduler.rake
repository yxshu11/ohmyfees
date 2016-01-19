desc "This task is called by the Heroku scheduler add-on"
task :check_due_fees => :environment do
  puts "Checking fees that going to be due..."
  # Check the fees that going to be due.
  StudentFee.all.each do |sf|
    # If the fees' due date is less than 2 days,
    # email the student and notify then about the payment.
    if  sf.due_date < 1.days # sf.payment.blank? &&
      s = Student.find_by(id: sf.student_id)
      # Email the student about the payment is about to due soon.
      StudentMailer.due_payment(s, sf).deliver_now
      
      # SMS the student about the the payment is about to due soon.

      # To be implemented as extra features with Twillio API.
    end
  end
  puts "Task done."
end

task :check_outstanding_fees => :environment do
  puts "Checking the outstanding fees that have not been paid yet..."
  # Check the outstanding fees for the students.
  self.all.each do |sf|
    # If the payment is outstanding for a period of time, fine will be added based on the condition
    if sf.due_date < DateTime.now # && sf.payment.blank?

    end
    # Email the student about the fine statements.
    # SMS the student about the outstandiing statements
  end
  puts "Task done."
end

task :check_fine_fees => :environment do
  puts "Checking the fine that have not been paid yet..."
  # Check the fees that is outstanding and with fines.
  # Fine.all.each do |f|
  #
  # end
  # Email the student about the fine statements.
  # SMS the student about the fine statements.
  puts "Task done."
end
