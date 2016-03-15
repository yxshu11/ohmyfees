require 'test_helper'

class LocationsControllerTest < ActionController::TestCase

  def setup
    @location = locations(:location)
    @admin_staff = users(:admin_staff)
    @nonadmin_staff = users(:nonadmin_staff)
  end

  test "nonadmin staff should be redirected to dashboard" do
    log_in_as(@nonadmin_staff, remember_me: '1')
    get :new
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should get new" do
    log_in_as(@admin_staff, remember_me: '1')
    get :new
    assert_response :success
  end

  test "should post create" do
    log_in_as(@admin_staff, remember_me: '1')
    assert_difference 'Location.count', 1 do
      post :create, location: { name: "Testing Location",
                                latitude: 3.047882,
                                longitude: 101.692862 }
    end
    assert_not flash.empty?
    assert_redirected_to locations_path
    assert_equal 'Location saved successfully.', flash[:success]
  end

  test "should get edit" do
    log_in_as(@admin_staff, remember_me: '1')
    get :edit, id: @location
    assert_response :success
  end

  test "should patch update" do
    log_in_as(@admin_staff, remember_me: '1')
    patch :update, id: @location, location: {name: "Location Testing A" }
    assert_not flash.empty?
    assert_redirected_to location_path(assigns(:location))
    assert_equal 'Location updated successfully.', flash[:success]
  end

  test "should get index" do
    log_in_as(@admin_staff, remember_me: '1')
    get :index
    assert_response :success
  end

  test "should get show" do
    log_in_as(@admin_staff, remember_me: '1')
    get :show, id: @location
    assert_response :success
  end
end
