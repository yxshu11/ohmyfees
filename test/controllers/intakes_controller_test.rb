require 'test_helper'

class IntakesControllerTest < ActionController::TestCase

  def setup
    @admin_staff = users(:admin_staff)
    @programme = programmes(:programme_a)
    @intake = intakes(:intake_a)
  end

  test "should get new" do
    log_in_as(@admin_staff, remember_me: '1')
    session[:programme_id] = @programme.id
    get :new
    assert_response :success
  end

  test "should post create" do
    log_in_as(@admin_staff, remember_me: '1')
    session[:programme_id] = @programme.id
    assert_difference 'Intake.count', 1 do
      post :create, intake: { intake_code: "UC1F1601SE",
                              starting_date: DateTime.now,
                              local_student_fee: 10000,
                              international_student_fee: 8000,
                              programme_id: @programme.id }
    end
    assert_not flash.empty?
    assert_redirected_to programme_path(@programme.id)
    assert_equal 'Intake added.', flash[:success]
  end

  test "should get show" do
    log_in_as(@admin_staff, remember_me: '1')
    get :show, id: @intake
    assert_response :success
  end

  test "should get index" do
    log_in_as(@admin_staff, remember_me: '1')
    get :index
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@admin_staff, remember_me: '1')
    get :edit, id: @intake
    assert_response :success
  end

  test "should patch update" do
    log_in_as(@admin_staff, remember_me: '1')
    patch :update, id: @intake, intake: {starting_date: DateTime.now,
                                         local_student_fee: 16000}
    assert_not flash.empty?
    assert_redirected_to intake_path(assigns(:intake))
    assert_equal 'Intake details updated.', flash[:success]
  end

end
