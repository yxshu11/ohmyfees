require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  def setup
    @student = Student.new(name: "FirstName SecondName",
                           email: "TP099999@mail.apu.edu.my",
                           student_number: "TP099999",
                           contact_number: "0123456789",
                           intake: "UC3F1608SE",
                           international: false,
                           tfa: false,
                           password: "111111",
                           password_confirmation: "111111")
  end

  test "student should be valid" do
    assert @student.valid?
  end

  test "name should be presented" do
    @student.name = " "
    assert_not @student.valid?
  end

  test "name should not be too long" do
    @student.name = "a" * 101
    assert_not @student.valid?
  end

  test "email should be presented" do
    @student.email = " "
    assert_not @student.valid?
  end

  test "email should be in @mail.apu.edu.my format" do
    invalid_addresses = %w[testing@gmail.com TP028811@apu.edu.my TP02811@mail.apu
                           alieeeos@mail.apu.edu.my 02028815@mail.apu.edu.my
                           appledseed@outlook.com]
    invalid_addresses.each do |invalid_address|
      @student.email = invalid_address
      assert_not @student.valid?, "#{invalid_address.inspect} should be valid"
    end
  end

  # test "email addresses should be unique" do
  #   duplicate_student = @student.dup
  #   duplicate_student.email = @student.email.downcase
  #   @student.save
  #   assert_not duplicate_student.valid?
  # end

  test "contact_number should be presented" do
    @student.contact_number = " "
    assert_not @student.valid?
  end

  test "contact number should be maximum 11 numbers" do
    @student.contact_number = "012345678910"
    assert_not @student.valid?
  end

  test "password should be presented" do
    @student.password = ""
    @student.password_confirmation = ""
    assert_not @student.valid?
  end

  test "password should be minumum 6 cahracters" do
    @student.password = "12345"
    @student.password_confirmation = "12345"
    assert_not @student.valid?
  end

end
