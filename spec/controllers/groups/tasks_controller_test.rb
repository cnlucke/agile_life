require 'test_helper'

class Groups::TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get groups_tasks_index_url
    assert_response :success
  end

  test "should get show" do
    get groups_tasks_show_url
    assert_response :success
  end

end
