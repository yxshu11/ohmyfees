require 'test_helper'

class ProgrammesControllerTest < ActionController::TestCase

  def setup
    @base_title = "| OHMYFEES"
    @admin_staff = users(:admin_staff)
    @nonadmin_staff = users(:nonadmin_staff)
    @programme = programmes(:programme_a)
  end

  test "should redirect went is not logged in" do
    assert_no_difference 'Programme.count' do
      delete :destroy, id: @admin_staff
    end
    assert_redirected_to login_path
  end

  test "should get new" do
    log_in_as(@admin_staff, remember_me: '1')
    get :new
    assert_response :success
    assert_select "title", "Programme Registration #{@base_title}"
  end

  test "should post create" do
    log_in_as(@admin_staff, remember_me: '1')
    assert_difference 'Programme.count', 1 do
      post :create, programme: { name: "Foundation Programme A",
                                 programme_type: "Fondation Programme",
                                 year: 1,
                                 semester: 3,
                                 desription: "This is an description"}
    end
    assert_not flash.empty?
    assert_redirected_to programme_path(assigns(:programme))
    assert_equal 'Programme saved.', flash[:success]
  end

  test "should get edit" do
    log_in_as(@admin_staff, remember_me: '1')
    get :edit, id: @programme
    assert_response :success
    assert_select "title", "Edit Programme Details #{@base_title}"
  end

  test "should patch update" do
    log_in_as(@admin_staff, remember_me: '1')
    patch :update, id: @programme, programme: {name: "Programme A",
                                               programme_type: "Fondation Programme",
                                               year: 3,
                                               semester: 6,
                                               desription: "This is an description"}
    assert_not flash.empty?
    assert_redirected_to programme_path(assigns(:programme))
    assert_equal 'Programme details updated.', flash[:success]
  end

  test "should get show" do
    log_in_as(@admin_staff, remember_me: '1')
    assert_response :success
  end

  test "should get index" do
    log_in_as(@admin_staff, remember_me: '1')
    get :index
    assert_response :success
    assert_select "title", "All Programmes #{@base_title}"
  end
end
