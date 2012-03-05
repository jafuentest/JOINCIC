require 'test_helper'

class PonenciasControllerTest < ActionController::TestCase
  setup do
    @ponencia = ponencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ponencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ponencia" do
    assert_difference('Ponencia.count') do
      post :create, ponencia: @ponencia.attributes
    end

    assert_redirected_to ponencia_path(assigns(:ponencia))
  end

  test "should show ponencia" do
    get :show, id: @ponencia.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ponencia.to_param
    assert_response :success
  end

  test "should update ponencia" do
    put :update, id: @ponencia.to_param, ponencia: @ponencia.attributes
    assert_redirected_to ponencia_path(assigns(:ponencia))
  end

  test "should destroy ponencia" do
    assert_difference('Ponencia.count', -1) do
      delete :destroy, id: @ponencia.to_param
    end

    assert_redirected_to ponencias_path
  end
end
