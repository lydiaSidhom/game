require 'test_helper'

class MetroStopsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get import" do
    get :import
    assert_response :success
  end

end
