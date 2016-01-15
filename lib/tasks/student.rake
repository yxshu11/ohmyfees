namespace :student do
  desc "Check the student fees and determine the fine for outstanding payment."
  task CheckStudentFees: :environment do
    # Run the worker to check the student fees
    CheckStudentFeesWorker.new.perform
    # Done
  end
end
