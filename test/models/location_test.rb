require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  def setup
    @location = Location.new(name: "Location 1",
                             latitude: 3.047882,
                             longitude: 101.692862)
  end

  test "location should be valid" do
    assert @location.valid?
  end

  test "location name should be presented" do
    @location.name = " "
    assert_not @location.valid?
  end

  test "latitude should be presented" do
    @location.latitude = " "
    assert_not @location.valid?
  end

  test "latitude should be in number format" do
    @location.latitude = "abc"
    assert_not @location.valid?
  end

  test "longitude should be presented" do
    @location.longitude = " "
    assert_not @location.valid?
  end

  test "logitude should be in number format" do
    @location.longitude = "abc"
    assert_not @location.valid?
  end
end
