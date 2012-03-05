require 'test_helper'

class MesasDeTrabajoControllerTest < ActionController::TestCase
  setup do
    @mesa_de_trabajo = mesas_de_trabajo(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mesas_de_trabajo)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mesa_de_trabajo" do
    assert_difference('MesaDeTrabajo.count') do
      post :create, mesa_de_trabajo: @mesa_de_trabajo.attributes
    end

    assert_redirected_to mesa_de_trabajo_path(assigns(:mesa_de_trabajo))
  end

  test "should show mesa_de_trabajo" do
    get :show, id: @mesa_de_trabajo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mesa_de_trabajo.to_param
    assert_response :success
  end

  test "should update mesa_de_trabajo" do
    put :update, id: @mesa_de_trabajo.to_param, mesa_de_trabajo: @mesa_de_trabajo.attributes
    assert_redirected_to mesa_de_trabajo_path(assigns(:mesa_de_trabajo))
  end

  test "should destroy mesa_de_trabajo" do
    assert_difference('MesaDeTrabajo.count', -1) do
      delete :destroy, id: @mesa_de_trabajo.to_param
    end

    assert_redirected_to mesas_de_trabajo_path
  end
end
