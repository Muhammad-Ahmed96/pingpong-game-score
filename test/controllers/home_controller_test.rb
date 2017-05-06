require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should redirect if get index and logged out" do
    get :index
    assert_response :redirect
  end

  test "should get index if logged in" do
    user = users(:default)
    sign_in user

    get :index
    assert_response :success
  end

  test "should get log page" do
    user = users(:default)
    sign_in user

    get :log
    assert_response :success
  end

  test "should get history page" do
    user = users(:default)
    sign_in user

    get :history
    assert_response :success
  end
end
