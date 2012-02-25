require 'test_helper'

class OrganizadoresControllerTest < ActionController::TestCase
  setup do
    @organizador = organizadores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizadores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organizador" do
    assert_difference('Organizador.count') do
      post :create, organizador: @organizador.attributes
    end

    assert_redirected_to organizador_path(assigns(:organizador))
  end

  test "should show organizador" do
    get :show, id: @organizador.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organizador.to_param
    assert_response :success
  end

  test "should update organizador" do
    put :update, id: @organizador.to_param, organizador: @organizador.attributes
    assert_redirected_to organizador_path(assigns(:organizador))
  end

  test "should destroy organizador" do
    assert_difference('Organizador.count', -1) do
      delete :destroy, id: @organizador.to_param
    end

    assert_redirected_to organizadores_path
  end
end
