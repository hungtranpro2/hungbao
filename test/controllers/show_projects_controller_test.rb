require 'test_helper'

class ShowProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get show_projects_show_url
    assert_response :success
  end

end
