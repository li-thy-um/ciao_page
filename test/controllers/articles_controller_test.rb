require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should get articles index" do
    get :index
    assert_response :success
  end

  test "should get articles new" do
    get :new
    assert_response :redirect
    assert_redirected_to admin_login_url
  end

end
