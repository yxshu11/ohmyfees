require 'test_helper'

class UtilityFeesControllerTest < ActionController::TestCase

  def setup
    @admin_staff = users(:admin_staff)
    @utility_fee = utility_fees(:utility_fee)
  end

  test "should get new" do
    log_in_as @admin_staff
    get :new
    assert_response :success
  end

  test "should post create" do
    log_in_as @admin_staff
    assert_difference 'UtilityFee.count', 1 do
      post :create, utility_fee: {name: "Utility Fee A",
                                  amount: 100,
                                  repetitive_payment: false,
                                  desription: "This is an description"}
    end
    assert_not flash.empty?
    assert_redirected_to utility_fees_path
    assert_equal 'Utility fee saved.', flash[:success]
  end

  test "should get show" do
    log_in_as @admin_staff
    get :show, id: @utility_fee
    assert_response :success
  end

  test "should get edit" do
    log_in_as @admin_staff
    get :edit, id: @utility_fee
    assert_response :success
  end

  test "should patch update" do
    log_in_as(@admin_staff)
    patch :update, id: @utility_fee, utility_fee: {name: "Utility Fee A+"}
    assert_not flash.empty?
    assert_redirected_to utility_fee_path(assigns(:utility_fee))
    assert_equal 'Utility fee details updated.', flash[:success]
  end

  test "should get index" do
    log_in_as @admin_staff
    get :index
    assert_response :success
  end


end
