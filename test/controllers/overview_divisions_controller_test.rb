require 'test_helper'

class OverviewDivisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get overview_divisions_index_url
    assert_response :success
  end

end
