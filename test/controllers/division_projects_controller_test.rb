require 'test_helper'

class DivisionProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get division_projects_index_url
    assert_response :success
  end

end
