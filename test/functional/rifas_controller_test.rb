require 'test_helper'

class RifasControllerTest < ActionController::TestCase
  setup do
    @rifa = rifas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rifas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rifa" do
    assert_difference('Rifa.count') do
      post :create, rifa: @rifa.attributes
    end

    assert_redirected_to rifa_path(assigns(:rifa))
  end

  test "should show rifa" do
    get :show, id: @rifa.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rifa.to_param
    assert_response :success
  end

  test "should update rifa" do
    put :update, id: @rifa.to_param, rifa: @rifa.attributes
    assert_redirected_to rifa_path(assigns(:rifa))
  end

  test "should destroy rifa" do
    assert_difference('Rifa.count', -1) do
      delete :destroy, id: @rifa.to_param
    end

    assert_redirected_to rifas_path
  end
end
