require 'test_helper'

class ProgrammesControllerTest < ActionController::TestCase

  def setup
    @base_title = "| OHMYFEES"
    @admin_staff = users(:admin_staff)
  end

  test "should get new" do
    log_in_as(@admin_staff, remember_me: '1')
    get :new
    assert_response :success
    assert_select "title", "Programme Registration #{@base_title}"
  end
end
