require 'test_helper'

class TemplateControllerTest < ActionController::TestCase
  test "should get migr" do
    get :migr
    assert_response :success
  end

  test "should get mod" do
    get :mod
    assert_response :success
  end

  test "should get ctrl" do
    get :ctrl
    assert_response :success
  end

  test "should get vi" do
    get :vi
    assert_response :success
  end

  test "should get sp_ctrl" do
    get :sp_ctrl
    assert_response :success
  end

  test "should get sp_mod" do
    get :sp_mod
    assert_response :success
  end

  test "should get sp_vi" do
    get :sp_vi
    assert_response :success
  end

end
