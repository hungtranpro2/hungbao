require 'test_helper'

class MyCalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_calendars_index_url
    assert_response :success
  end

end
