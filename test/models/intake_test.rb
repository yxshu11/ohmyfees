require 'test_helper'

class IntakeTest < ActiveSupport::TestCase

  def setup
    @programme = programmes(:programme_one)
    @intake = Intake.new(intake_code: "UC1F1601",
                         starting_date: DateTime.now,
                         local_student_fee: 16000,
                         international_student_fee: 13000,
                         programme_id: @programme.id)
  end

  test "intake should be valid" do
    assert @intake.valid?
  end

  test "intake code should be presented" do
    @intake.intake_code = " "
    assert_not @intake.valid?
  end

  test "starting date should be presented" do
    @intake.starting_date = " "
    assert_not @intake.valid?
  end

  test "local student fee should be presented" do
    @intake.local_student_fee = " "
    assert_not @intake.valid?
  end

  test "international student fee should be presented" do
    @intake.international_student_fee = " "
    assert_not @intake.valid?
  end

  test "programme id should be presented" do
    @intake.programme_id = nil
    assert_not @intake.valid?
  end
end
