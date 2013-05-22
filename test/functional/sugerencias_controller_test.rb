require 'test_helper'

class SugerenciasControllerTest < ActionController::TestCase
  setup do
    @sugerencia = sugerencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sugerencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sugerencia" do
    assert_difference('Sugerencia.count') do
      post :create, :sugerencia => @sugerencia.attributes
    end

    assert_redirected_to sugerencia_path(assigns(:sugerencia))
  end

  test "should show sugerencia" do
    get :show, :id => @sugerencia.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sugerencia.to_param
    assert_response :success
  end

  test "should update sugerencia" do
    put :update, :id => @sugerencia.to_param, :sugerencia => @sugerencia.attributes
    assert_redirected_to sugerencia_path(assigns(:sugerencia))
  end

  test "should destroy sugerencia" do
    assert_difference('Sugerencia.count', -1) do
      delete :destroy, :id => @sugerencia.to_param
    end

    assert_redirected_to sugerencias_path
  end
end
