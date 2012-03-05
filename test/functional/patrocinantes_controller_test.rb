require 'test_helper'

class PatrocinantesControllerTest < ActionController::TestCase
  setup do
    @patrocinante = patrocinantes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patrocinantes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patrocinante" do
    assert_difference('Patrocinante.count') do
      post :create, patrocinante: @patrocinante.attributes
    end

    assert_redirected_to patrocinante_path(assigns(:patrocinante))
  end

  test "should show patrocinante" do
    get :show, id: @patrocinante.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @patrocinante.to_param
    assert_response :success
  end

  test "should update patrocinante" do
    put :update, id: @patrocinante.to_param, patrocinante: @patrocinante.attributes
    assert_redirected_to patrocinante_path(assigns(:patrocinante))
  end

  test "should destroy patrocinante" do
    assert_difference('Patrocinante.count', -1) do
      delete :destroy, id: @patrocinante.to_param
    end

    assert_redirected_to patrocinantes_path
  end
end
