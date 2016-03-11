require 'test_helper'

class StaffTest < ActiveSupport::TestCase

  def setup
    @staff = Staff.new(name: "FirstName SecondName",
                       email: "first.second@apu.edu.my",
                       staff_number: "SA123456",
                       contact_number: "0123456789",
                       password: "111111",
                       password_confirmation: "111111")
  end

  test "staff should be valid" do
    assert @staff.valid?
  end

  test "name should be presented" do
    @staff.name = " "
    assert_not @staff.valid?
  end

  test "name should not be too long" do
    @staff.name = "a" * 101
    assert_not @staff.valid?
  end

  test "email should be presented" do
    @staff.email = " "
    assert_not @staff.valid?
  end

  test "email should be in @apu.edu.my format" do
    invalid_addresses = %w[testing@gmail.com TP028811@mail.apu.edu.my TP02811@mail.apu
                           alieeeos@apiit.edu.my 02028815@ex.apiit.edu.my
                           appledseed@outlook.com]
    invalid_addresses.each do |invalid_address|
      @staff.email = invalid_address
      assert_not @staff.valid?, "#{invalid_address.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_staff = @staff.dup
    duplicate_staff.email = @staff.email.downcase
    @staff.save
    assert_not duplicate_staff.valid?
  end

  test "staff number should be presented" do
    @staff.staff_number = " "
    assert_not @staff.valid?
  end

  test "staff number should be not too long" do
    @staff.staff_number = "S" * 16
    assert_not @staff.valid?
  end

  test "staff number should be unique" do
    duplicate_staff = @staff.dup
    duplicate_staff.staff_number = @staff.staff_number.downcase
    @staff.save
    assert_not duplicate_staff.valid?
  end

  test "contact_number should be presented" do
    @staff.contact_number = " "
    assert_not @staff.valid?
  end

  test "contact number should be maximum 11 numbers" do
    @staff.contact_number = "012345678910"
    assert_not @staff.valid?
  end

  test "password should be presented" do
    @staff.password = ""
    @staff.password_confirmation = ""
    assert_not @staff.valid?
  end

  test "password should be minumum 6 cahracters" do
    @staff.password = "12345"
    @staff.password_confirmation = "12345"
    assert_not @staff.valid?
  end
end
