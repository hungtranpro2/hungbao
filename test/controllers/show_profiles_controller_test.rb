require 'test_helper'

class ShowProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get show_profiles_index_url
    assert_response :success
  end

end
