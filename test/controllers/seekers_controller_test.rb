require 'test_helper'

class SeekersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get seekers_new_url
    assert_response :success
  end

  test "should get create" do
    get seekers_create_url
    assert_response :success
  end

end
