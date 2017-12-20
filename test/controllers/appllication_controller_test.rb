require 'test_helper'

class AppllicationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get appllication_new_url
    assert_response :success
  end

  test "should get create" do
    get appllication_create_url
    assert_response :success
  end

  test "should get delete" do
    get appllication_delete_url
    assert_response :success
  end

  test "should get update" do
    get appllication_update_url
    assert_response :success
  end

end
