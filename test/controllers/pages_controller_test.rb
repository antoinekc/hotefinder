require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get team" do
    get pages_team_url
    assert_response :success
  end
end
