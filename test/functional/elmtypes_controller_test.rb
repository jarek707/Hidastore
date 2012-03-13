require 'test_helper'

class ElmtypesControllerTest < ActionController::TestCase
  setup do
    @elmtype = elmtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:elmtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create elmtype" do
    assert_difference('Elmtype.count') do
      post :create, elmtype: @elmtype.attributes
    end

    assert_redirected_to elmtype_path(assigns(:elmtype))
  end

  test "should show elmtype" do
    get :show, id: @elmtype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @elmtype.to_param
    assert_response :success
  end

  test "should update elmtype" do
    put :update, id: @elmtype.to_param, elmtype: @elmtype.attributes
    assert_redirected_to elmtype_path(assigns(:elmtype))
  end

  test "should destroy elmtype" do
    assert_difference('Elmtype.count', -1) do
      delete :destroy, id: @elmtype.to_param
    end

    assert_redirected_to elmtypes_path
  end
end
