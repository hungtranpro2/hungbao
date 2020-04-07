require 'test_helper'

class AddProjectDivisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get add_project_divisions_index_url
    assert_response :success
  end

end
