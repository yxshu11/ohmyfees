# Generate Staff Account (Admin)
Staff.create!(name: "John Testing",
              staff_number: "SA000238",
              email: "testing@apu.edu.my",
              contact_number: "0123456789",
              password: "111111",
              password_confirmation: "111111",
              admin: true)

Staff.create!(name: "John NonAdmin",
              staff_number: "SA000239",
              email: "testing2@apu.edu.my",
              contact_number: "0123456789",
              password: "111111",
              password_confirmation: "111111",
              admin: false)

4.times do |n|
  name = Faker::Name.name
  staff_number = "SA#{100000+(n+1)}"
  email = "#{name.delete " "}@apu.edu.my"
  contact_number = "011123#{1000+(n+1)}"
  password = "password"
  Staff.create!(name: name,
                  staff_number: staff_number,
                  email: email,
                  contact_number: contact_number,
                  password: password,
                  password_confirmation: password,
                  admin: false)
end

# Generate Programmes
Programme.create!(name: "BSc (Hons) in Software Engineering",
                  programme_type: "Undergraduate Studies",
                  year: 3,
                  semester: 6,
                  description: "This programme is specifically designed to provide the familiarity with the tools and rigorous methodologies used to develop mission-critical and safety-critical software systems.
                  The ability to critically evaluate design paradigms, languages, algorithms, and techniques used to develop large-scale and complex software systems.
                  A deep appreciation of the importance of software architecture, testing, documentation, and maintainability.")

Programme.create!(name: "BSc (Hons) in Intelligent Systems",
                  programme_type: "Undergraduate Studies",
                  year: 3,
                  semester: 6,
                  description: "This programme is specifically designed to provide the ability to design and develop systems that exploit artificial intelligence techniques such as machine learning, fuzzy logic, natural language processing, etc.
                  The ability to critically evaluate design paradigms, languages, algorithms, and techniques used to develop complex software systems.
                  The ability to evaluate and respond to opportunities for developing and exploiting new applications of artificial intelligence.")

Programme.create!(name: "APU Foundation Programme",
                  programme_type: "Foundation Programme",
                  year: 1,
                  semester: 3,
                  description: "APU Foundation (Pre-University) programme is designed to help those with SPM,
                  O Levels or similar qualifications to develop the skills and knowledge to progress into the first year of degree of choice.
                  Throughout the programme, our academic staff will advise you on the options available at each stage of your university degree study.")

Programme.create!(name: "Diploma in Information & Communication Technology",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "This programme is specifically designed to provide the coverage of the academic aspect as well as the vocational aspect of the wide area of Computing and Information and Communications Technology.
                  Students with the skills to prepare them for careers in the ICT environment with emphasis on solutions design, software development and technology infrastructure support.
                  Students with academic and professional skills to develop solutions requiring the application of technology in a business and organisational context, so as to facilitate response to continuous future changes in technology and industry practices.
                  Students with critical, independent and cooperative learning skills so as to facilitate responses to continuous future changes in industry practises.
                  Students with intellectual skills, communications ability and teamworking capability.
                  Students with opportunities for progression into advanced programmes of study of International standard in relevant areas.")

# Generate Intakes
Intake.create!(intake_code: "UCFF1601IT",
                starting_date: DateTime.new(2016,1,13),
                local_student_fee: 16700,
                international_student_fee: 15900,
                programme_id: 3)

Intake.create!(intake_code: "UC1F1601SE",
               starting_date: DateTime.new(2016,1,13),
               local_student_fee: 73700,
               international_student_fee: 68400,
               programme_id: 1)

Intake.create!(intake_code: "UC1F1601IS",
                starting_date: DateTime.new(2016,1,13),
                local_student_fee: 73700,
                international_student_fee: 68400,
                programme_id: 2)

# Generate Utility Fees
UtilityFee.create!(name: "Registration Fee",
                   amount: 300,
                   repetitive_payment: false,
                   description: "Student Registration fee for new comer.")

UtilityFee.create!(name: "Student ID Card",
                  amount: 30,
                  repetitive_payment: true,
                  description: "Fee for student ID card. NFC Chip built-in.")

UtilityFee.create!(name: "Library Deposit",
                   amount: 400,
                   repetitive_payment: false,
                   description: "Librabry Deposit for the APU Library Usage.")

UtilityFee.create!(name: "Library Fee",
                  amount: 100,
                  repetitive_payment: true,
                  description: "Librabry Fee for the APU Library Usage. Pay Yearly.")

# Generate Student Accounts
# Student.create!(name: "Shu Yee Xen",
#                  student_number: "TP028815",
#                  email: "TP028815@mail.apu.edu.my",
#                  intake: "UC1F1601SE",
#                  international: false,
#                  contact_number: "0123456789",
#                  password: "111111",
#                  password_confirmation: "111111",
#                  admin: false,
#                  activated: true,
#                  activated_at: Time.zone.now)

# Faker Gem generates dummy Student account in the database
# 99.times do |n|
#    name = Faker::Name.name
#    student_number = "TP#{100000+(n+1)}"
#    email = "TP#{100000+(n+1)}@mail.apu.edu.my"
#    intake = "UCFF1601IT"
#    contact_number = "016123#{1000+(n+1)}"
#    password = "password"
#    international = true
#    Student.create!(name: name,
#                    student_number: student_number,
#                    email: email,
#                    intake: intake,
#                    international: international,
#                    contact_number: contact_number,
#                    password: password,
#                    password_confirmation: password,
#                    admin: false,
#                    activated: true,
#                    activated_at: Time.zone.now)
# end

# StudentFee.create!(name: "Outstanding Fee (Testing)",
#                     amount: 500,
#                     due_date: DateTime.new(2016,1,10),
#                     description: "Testing the outstanding fees.",
#                     user_id: 7)
