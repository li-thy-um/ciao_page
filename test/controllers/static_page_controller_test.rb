require 'test_helper'

class StaticPageControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select 'title', 'Ciao.moe'
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select 'title', 'About me - Ciao.moe'
  end

  test "should get admin" do
    get :admin
    assert_response :redirect
  end

end
