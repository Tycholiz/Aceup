require 'test_helper'

class SavedJobsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get saved_jobs_new_url
    assert_response :success
  end

  test "should get create" do
    get saved_jobs_create_url
    assert_response :success
  end

  test "should get delete" do
    get saved_jobs_delete_url
    assert_response :success
  end

  test "should get update" do
    get saved_jobs_update_url
    assert_response :success
  end

end
