require 'test_helper'

class ProjectRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_requests_index_url
    assert_response :success
  end

end
