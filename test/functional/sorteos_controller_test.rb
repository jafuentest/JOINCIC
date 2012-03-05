require 'test_helper'

class SorteosControllerTest < ActionController::TestCase
  setup do
    @sorteo = sorteos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sorteos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sorteo" do
    assert_difference('Sorteo.count') do
      post :create, sorteo: @sorteo.attributes
    end

    assert_redirected_to sorteo_path(assigns(:sorteo))
  end

  test "should show sorteo" do
    get :show, id: @sorteo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sorteo.to_param
    assert_response :success
  end

  test "should update sorteo" do
    put :update, id: @sorteo.to_param, sorteo: @sorteo.attributes
    assert_redirected_to sorteo_path(assigns(:sorteo))
  end

  test "should destroy sorteo" do
    assert_difference('Sorteo.count', -1) do
      delete :destroy, id: @sorteo.to_param
    end

    assert_redirected_to sorteos_path
  end
end
