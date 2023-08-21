require "test_helper"

class EvsesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get evses_index_url
    assert_response :success
  end

  test "should get show" do
    get evses_show_url
    assert_response :success
  end
end
