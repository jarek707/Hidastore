require 'test_helper'

class ExposuresControllerTest < ActionController::TestCase
  setup do
    @exposure = exposures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exposures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exposure" do
    assert_difference('Exposure.count') do
      post :create, exposure: @exposure.attributes
    end

    assert_redirected_to exposure_path(assigns(:exposure))
  end

  test "should show exposure" do
    get :show, id: @exposure.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exposure.to_param
    assert_response :success
  end

  test "should update exposure" do
    put :update, id: @exposure.to_param, exposure: @exposure.attributes
    assert_redirected_to exposure_path(assigns(:exposure))
  end

  test "should destroy exposure" do
    assert_difference('Exposure.count', -1) do
      delete :destroy, id: @exposure.to_param
    end

    assert_redirected_to exposures_path
  end
end
