require "test_helper"

class ConnectorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get connectors_index_url
    assert_response :success
  end

  test "should get show" do
    get connectors_show_url
    assert_response :success
  end
end
