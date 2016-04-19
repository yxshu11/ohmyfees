# Generate Staff Account (Admin)
Staff.create!(name: "Johnny Appleseed",
              staff_number: "SA000238",
              email: "admin@apu.edu.my",
              contact_number: "0123456789",
              password: "111111",
              password_confirmation: "111111",
              admin: true)

Staff.create!(name: "John Appleseed",
              staff_number: "SA000239",
              email: "nonadmin@apu.edu.my",
              contact_number: "0123456789",
              password: "111111",
              password_confirmation: "111111",
              admin: false)

4.times do |n|
  name = Faker::Name.name
  staff_number = "SA#{100000+(n+1)}"
  email = "#{name.delete ". "}@apu.edu.my"
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
Programme.create!(name: "APU Foundation Programme",
                  programme_type: "Foundation Programme",
                  year: 1,
                  semester: 3,
                  description: "APU Foundation (Pre-University) programme is designed to help those with SPM,
                  O Levels or similar qualifications to develop the skills and knowledge to progress into the first year of degree of choice.
                  Throughout the programme, our academic staff will advise you on the options available at each stage of your university degree study.")

Intake.create!(intake_code: "UCFF1601",
                starting_date: DateTime.new(2016,1,13),
                local_student_fee: 10000,
                international_student_fee: 12000,
                programme_id: 1)

Programme.create!(name: "Diploma in Information & Communication Technology",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "This programme is specifically designed to provide the coverage of the academic aspect as well as the vocational aspect of the wide area of Computing and Information and Communications Technology. Students with the skills to prepare them for careers in the ICT environment with emphasis on solutions design, software development and technology infrastructure support. Students with academic and professional skills to develop solutions requiring the application of technology in a business and organisational context, so as to facilitate response to continuous future changes in technology and industry practices. Students with critical, independent and cooperative learning skills so as to facilitate responses to continuous future changes in industry practises. Students with intellectual skills, communications ability and teamworking capability. Students with opportunities for progression into advanced programmes of study of International standard in relevant areas.")

Intake.create!(intake_code: "UCDF1601ICT",
                starting_date: DateTime.new(2016,1,13),
                local_student_fee: 73700,
                international_student_fee: 68400,
                programme_id: 2)

Programme.create!(name: "Diploma in Information & Communications Technology with Specialism in Software Engineering",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "This programme is specifically designed to provide the students with skills in software systems development, with emphasis on aspects of software engineering. Students with the skills to prepare them for careers in the ICT environment with emphasis on solutions design, software development and technology infrastructure support. An appreciation of the proven principles and techniques for the development and support of software systems in commercial organisations. Students with critical, independent and cooperative learning skills so as to facilitate responses to continuous future changes in industry practises. Students with academic and professional skills to develop solutions requiring the application of technology in a business and organisational context, so as to respond to continuous future changes in technology and industry practices. Students with intellectual skills, communications ability and team working capability. Students with opportunities for progression into advanced programmes of study of International standard in relevant areas.")

Programme.create!(name: "Diploma in Business with Information Technology",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "This programme is specifically designed to provide the students for careers in hybrid environments where business information systems are increasingly integrated, encompassing a wide range of enabling technologies and cross organisational, social, national and international boundaries. Students with academic and professional skills to develop solutions requiring the application of both business and information technology disciplines in a commercial and organisational context. Students with critical, independent and cooperative learning skills so as to facilitate responses to continuous future changes in technology and industry practices. Students with intellectual skills, communications ability and team working capability.")

Programme.create!(name: "Diploma in Business Administration",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "This programme is specifically designed to provide the students for careers in the business administrative environment with emphasis on general business operations, organisation and specialisation option in accounting, tourism, information technology or marketing. Professional skills to develop solutions requiring a holistic outlook in the business and organisational context. Students with critical, independent and cooperative learning skills so as to facilitate response to continuous future changes in industry practices. Students with intellectual skills, communications ability and teamworking capability. Students with opportunities for progression into Degrees of study of International standard in relevant areas.")

Programme.create!(name: "Diploma in Accounting",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "This programme is specifically designed to provide the students for careers in the business, accounting and finance environment with emphasis on accounting practices, computerised accounting systems, financial management and economic outlook. Students with academic and professional skills to develop solutions requiring the application of marketing in a business and organisational context. Students with critical, independent and cooperative learning skills so as to facilitate response to continuous future changes in industry practices. Students with intellectual skills, communications ability and teamworking capability. Students with opportunities for progression into Degrees of study of International standard in relevant areas. To facilitate students’ pursue of professional qualifications from the professional accounting and financial bodies.")

Programme.create!(name: "Diploma in Design and Media",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "The Diploma in Design and Media is designed to provide a programme that covers the academic aspect as well as the vocational aspects of Design and Media. Prepare students for careers in the Design and Media environment. Provide students with academic and professional skills to develop solutions requiring a holistic outlook in Design Studies. Provide students with critical,  independent and cooperative learning skills so as to facilitate their  response to continuous future international change. Develop students' intellectual skills, communications ability and team working capability. Provide students with opportunities for progression into Degree Programmes of Design and Media standard in relevant areas.")

Programme.create!(name: "Diploma in Electrical and Electronic Engineering",
                  programme_type: "Diploma Programme",
                  year: 3,
                  semester: 6,
                  description: "The Diploma in Electrical and Electronic Engineering programme prepares you for careers in the Electrical, Electronics, Telecommunication, and Manufacturing environments. This programme offers a broad-based study in the areas of electrical and electronic engineering. A range of modules in the electrical and electronic engineering spectrum is provided. Other skills necessary for the workplace are also provided. These include communication skills and life-long learning skills. You will be equipped with the knowledge and expertise to face the challenges of business development in a wide range of electrical and electronic industries. The Electrical & Electronic Engineering programme at APIIT provides a significant amount of hands-on experience. The curriculum requires 6 semesters of laboratory experience in electrical and electronics. Hands on experience provide necessary experience in designing engineering solutions, dealing with implementation issues, and using engineering tools. In addition, you will be exposed with seminars & competitions to be part of the engineering world.")

Programme.create!(name: "Diploma in Finance",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "This programme is specifically designed to provide the preparation for the students with solid foundation in finance to meet the demands of wide range of careers in the business, accounting, banking and finance environment. Provide students with academic and professional skills to develop solutions requiring the application of finance in a business and industrial context. Students with critical, independent and cooperative learning skills so as to facilitate response to continuous changes in industry practices. Students with intellectual, communications and team working skills. Students with opportunities for progression into studies at degree level in relevant areas.")

Programme.create!(name: "Diploma in International Studies",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "International Studies is designed to provide a programme that covers the academic aspect as well as the vocational aspects of International Studies. Prepare students for careers in the International Studies environment. Provide students with academic and professional skills to develop solutions requiring a holistic outlook in International Studies. Provide students with critical,  independent and cooperative learning skills so as to facilitate their  response to continuous future international change. Develop students' intellectual skills, communications ability and team working capability. Provide students with opportunities for progression into Degrees of International standard in relevant areas.")

Programme.create!(name: "Diploma in Journalism",
                  programme_type: "Diploma Programme",
                  year: 2,
                  semester: 5,
                  description: "Diploma in Journalism is designed to provide a programme that covers the academic aspect as well as the vocational aspect of Journalism. Prepare students for careers in Journalism. Provide students with academic and professional skills to develop solutions requiring a holistic outlook Journalism. Provide students with critical, independent and cooperative learning skills so as to facilitate response to continuous future changes in industry practices. Develop students' intellectual skills, communications ability and team working capability. Provide students with opportunities for progression into Degrees of International standard in relevant areas.")

Programme.create!(name: "BSc (Hons) in Information Technology",
                  programme_type: "Undergraduate Studies",
                  year: 3,
                  semester: 6,
                  description: "This programme is specifically designed to provide the familiarity with a broad range of information technologies and how they are used. An understanding of frameworks and planning techniques for the strategic management of information systems in organisations. The ability to critically evaluate and apply appropriate strategies and techniques to the development of information technologies.")

Programme.create!(name: "BSc (Hons) in Computer Games Development",
                  programme_type: "Undergraduate Studies",
                  year: 3,
                  semester: 6,
                  description: "This programme is specifically designed to provide the knowledge, skills, and abilities required by a technical professional in the field of computer games. The ability to critically evaluate the design, logic, and implementation of computer games. Facility with advanced techniques for computer graphics and 3D digital animation.")

Intake.create!(intake_code: "UC1F1601CGD",
               starting_date: DateTime.new(2016,1,13),
               local_student_fee: 73700,
               international_student_fee: 68400,
               programme_id: 13)

Programme.create!(name: "BSc (Hons) in Software Engineering",
                  programme_type: "Undergraduate Studies",
                  year: 3,
                  semester: 6,
                  description: "This programme is specifically designed to provide the familiarity with the tools and rigorous methodologies used to develop mission-critical and safety-critical software systems. The ability to critically evaluate design paradigms, languages, algorithms, and techniques used to develop large-scale and complex software systems. A deep appreciation of the importance of software architecture, testing, documentation, and maintainability.")

Intake.create!(intake_code: "UC1F1601SE",
               starting_date: DateTime.new(2016,1,13),
               local_student_fee: 73700,
               international_student_fee: 68400,
               programme_id: 14)

Programme.create!(name: "BSc (Hons) in Intelligent Systems",
                  programme_type: "Undergraduate Studies",
                  year: 3,
                  semester: 6,
                  description: "This programme is specifically designed to provide the ability to design and develop systems that exploit artificial intelligence techniques such as machine learning, fuzzy logic, natural language processing, etc. The ability to critically evaluate design paradigms, languages, algorithms, and techniques used to develop complex software systems. The ability to evaluate and respond to opportunities for developing and exploiting new applications of artificial intelligence.")

Intake.create!(intake_code: "UC1F1601IS",
                starting_date: DateTime.new(2016,1,13),
                local_student_fee: 73700,
                international_student_fee: 68400,
                programme_id: 15)

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
Student.create!(name: "Shu Yee Xen",
                 student_number: "TP028815",
                 email: "TP028815@mail.apu.edu.my",
                 intake: "UC1F1601SE",
                 international: false,
                 contact_number: "0123456789",
                 tfa: true,
                 password: "111111",
                 password_confirmation: "111111",
                 admin: false,
                 activated: true,
                 activated_at: Time.zone.now)

Student.create!(name: "Homer Simpson",
                student_number: "TP099999",
                email: "TP099999@mail.apu.edu.my",
                intake: "UCFF1601",
                international: false,
                contact_number: "0123456789",
                tfa: false,
                password: "111111",
                password_confirmation: "111111",
                admin: false,
                activated: true,
                activated_at: Time.zone.now)

# Student.create!(name: "Jaemy Ho",
#                 student_number: "TP028816",
#                 email: "TP028816@mail.apu.edu.my",
#                 intake: "UC1F1601CGD",
#                 international: true,
#                 contact_number: "0123456789",
#                 tfa: false,
#                 password: "111111",
#                 password_confirmation: "111111",
#                 admin: false,
#                 activated: true,
#                 activated_at: Time.zone.now)

# Faker Gem generates dummy Student account in the database
# all_intake = ["UCFF1601","UC1F1601CGD","UC1F1601IS", "UC1F1601SE"]
# s_date = DateTime.now
# s_date = s_date.beginning_of_year..s_date.end_of_year
# 99.times do |n|
#    name = Faker::Name.name
#    student_number = "TP#{100000+(n+1)}"
#    email = "TP#{100000+(n+1)}@mail.apu.edu.my"
#    contact_number = "016123#{1000+(n+1)}"
#    password = "password"
#    international = true
#    Student.create!(name: name,
#                    student_number: student_number,
#                    email: email,
#                    intake: all_intake.sample,
#                    international: international,
#                    contact_number: contact_number,
#                    tfa: false
#                    password: password,
#                    password_confirmation: password,
#                    admin: false,
#                    activated: true,
#                    activated_at: Time.zone.now,
#                    created_at: rand(s_date))
# end

StudentFee.create!(name: "Outstanding Fee 1",
                    amount: 10,
                    due_date: DateTime.new(2016,3,20),
                    description: "Testing the outstanding fees 1.",
                    user_id: 7,
                    paid: false)

StudentFee.create!(name: "Outstanding Fee 2",
                    amount: 20,
                    due_date: Date.new(2016,3,20),
                    description: "Testing the outstanding fees 2.",
                    user_id: 7,
                  paid: false)

# amount = [100, 30, 400, 12388, 3359]
# paid_by = ["Student", "Staff"]
# payment_method = ["Cash", "Online", "Cheque", "Bank Transfer"]
# date = DateTime.now
# date = date.beginning_of_year..date.end_of_year
# 150.times do |n|
#   Payment.create!(amount: amount.sample,
#                   paid_by: paid_by.sample,
#                   payment_method: payment_method.sample,
#                   student_fee_id: "7",
#                   created_at: rand(date))
# end

Location.create!(name: "Asia Pacific Institute Of Information Technology @ TPM",
                 latitude: 3.047882,
                 longitude: 101.692862)

Location.create!(name: "Asia Pacific Institute Of Information Technology @ ENT3",
                 latitude: 3.048416,
                 longitude: 101.690815)

Location.create!(name: "Asia Pacific Institute Of Information Technology @ MINES",
                 latitude: 3.042048,
                 longitude: 101.708975)

Location.create!(name: "Vista Komanwel A",
                 latitude: 3.059975,
                 longitude: 101.685526)
