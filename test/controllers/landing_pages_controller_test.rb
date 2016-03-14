require 'test_helper'

class LandingPagesControllerTest < ActionController::TestCase

  def setup
    @base_title = "OHMYFEES"
    @activated_student = users(:activated_student)
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get dashboard" do
    log_in_as(@activated_student, remember_me: '1')
    get :dashboard
    assert_response :success
    assert_select "title", "Dashboard | #{@base_title}"
  end
end
