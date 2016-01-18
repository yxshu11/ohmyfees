desc "This task is called by the Heroku scheduler add-on"
task :check_student_fees => :environment do
  puts "Checking fees..."
  StudentFee.check_fees
  puts "Task Done."
end
