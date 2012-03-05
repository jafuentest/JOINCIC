require 'test_helper'

class PonentesControllerTest < ActionController::TestCase
  setup do
    @ponente = ponentes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ponentes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ponente" do
    assert_difference('Ponente.count') do
      post :create, ponente: @ponente.attributes
    end

    assert_redirected_to ponente_path(assigns(:ponente))
  end

  test "should show ponente" do
    get :show, id: @ponente.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ponente.to_param
    assert_response :success
  end

  test "should update ponente" do
    put :update, id: @ponente.to_param, ponente: @ponente.attributes
    assert_redirected_to ponente_path(assigns(:ponente))
  end

  test "should destroy ponente" do
    assert_difference('Ponente.count', -1) do
      delete :destroy, id: @ponente.to_param
    end

    assert_redirected_to ponentes_path
  end
end
