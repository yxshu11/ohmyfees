Student.create!(name: "Shu Yee Xen",
                student_number: "TP028815",
                email: "TP028815@mail.apu.edu.my",
                intake: "UC3F1508SE",
                contact_number: "0123456789",
                password: "111111",
                password_confirmation: "111111",
                admin: false)

# Faker Gem generates dummy Student account in the database
99.times do |n|
  name = Faker::Name.name
  student_number = "TP#{100000+(n+1)}"
  email = "TP#{100000+(n+1)}@mail.apu.edu.my"
  intake = "UC3F1508IT"
  contact_number = "016123#{1000+(n+1)}"
  password = "password"
  Student.create!(name: name,
                  student_number: student_number,
                  email: email,
                  intake: intake,
                  contact_number: contact_number,
                  password: password,
                  password_confirmation: password,
                  admin: false)
end

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
