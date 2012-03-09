require 'test_helper'

class PlugsControllerTest < ActionController::TestCase
  setup do
    @plug = plugs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plugs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plug" do
    assert_difference('Plug.count') do
      post :create, plug: @plug.attributes
    end

    assert_redirected_to plug_path(assigns(:plug))
  end

  test "should show plug" do
    get :show, id: @plug.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plug.to_param
    assert_response :success
  end

  test "should update plug" do
    put :update, id: @plug.to_param, plug: @plug.attributes
    assert_redirected_to plug_path(assigns(:plug))
  end

  test "should destroy plug" do
    assert_difference('Plug.count', -1) do
      delete :destroy, id: @plug.to_param
    end

    assert_redirected_to plugs_path
  end
end
