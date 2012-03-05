require 'test_helper'

class ParticipantesMesasControllerTest < ActionController::TestCase
  setup do
    @participante_mesa = participantes_mesas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participantes_mesas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participante_mesa" do
    assert_difference('ParticipanteMesa.count') do
      post :create, participante_mesa: @participante_mesa.attributes
    end

    assert_redirected_to participante_mesa_path(assigns(:participante_mesa))
  end

  test "should show participante_mesa" do
    get :show, id: @participante_mesa.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participante_mesa.to_param
    assert_response :success
  end

  test "should update participante_mesa" do
    put :update, id: @participante_mesa.to_param, participante_mesa: @participante_mesa.attributes
    assert_redirected_to participante_mesa_path(assigns(:participante_mesa))
  end

  test "should destroy participante_mesa" do
    assert_difference('ParticipanteMesa.count', -1) do
      delete :destroy, id: @participante_mesa.to_param
    end

    assert_redirected_to participantes_mesas_path
  end
end
