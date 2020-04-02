require 'test_helper'

class ProjectDivisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_divisions_index_url
    assert_response :success
  end

end
