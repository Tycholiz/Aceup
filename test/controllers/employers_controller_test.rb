require 'test_helper'

class EmployersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get employers_new_url
    assert_response :success
  end

  test "should get create" do
    get employers_create_url
    assert_response :success
  end

end
