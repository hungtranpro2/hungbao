require 'test_helper'

class AddProjectManagersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get add_project_managers_index_url
    assert_response :success
  end

end
