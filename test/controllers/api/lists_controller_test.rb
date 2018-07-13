require 'test_helper'

class Api::ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_lists_create_url
    assert_response :success
  end

end
