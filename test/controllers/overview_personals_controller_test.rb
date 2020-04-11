require 'test_helper'

class OverviewPersonalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get overview_personals_index_url
    assert_response :success
  end

end
