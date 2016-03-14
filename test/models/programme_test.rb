require 'test_helper'

class ProgrammeTest < ActiveSupport::TestCase

  def setup
    @programme = Programme.new(name: "Foundation Programme",
                               programme_type: "Foundation Programme",
                               year: 1,
                               semester: 3,
                               description: "This is a description.")
  end

  test "programme should be valid" do
    assert @programme.valid?
  end

  test "name should be presented" do
    @programme.name = " "
    assert_not @programme.valid?
  end

  test "name should not be too long" do
    @programme.name = "a" * 101
    assert_not @programme.valid?
  end

  test "programme type should be presented" do
    @programme.programme_type = " "
    assert_not @programme.valid?
  end

  test "year should be presented" do
    @programme.year = " "
    assert_not @programme.valid?
  end

  test "year should be in integer format" do
    @programme.year = 1.2
    assert_not @programme.valid?
  end

  test "semester should be presented" do
    @programme.semester = " "
    assert_not @programme. valid?
  end

  test "semester should be in integer format" do
    @programme.semester = 1.2
    assert_not @programme.valid?
  end
end
