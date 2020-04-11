require 'test_helper'

class CompanyProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get company_projects_index_url
    assert_response :success
  end

end
