require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'landing_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", student_registration_path
    assert_select "a[href=?]", "https://www.outlook.com/owa/mail.apu.edu.my"
    assert_select "a[href=?]", "http://webspace.apiit.edu.my/"

    get student_registration_path
    assert_select "title", full_title("Student Registration")
  end

  # test "dashboard layout links" do
  #   get dashboard_path
  #   assert_template 'landing_pages/dasboard'
  # end
end
