require 'test_helper'

class ParticipantesMatesControllerTest < ActionController::TestCase
  setup do
    @participante_mate = participantes_mates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participantes_mates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participante_mate" do
    assert_difference('ParticipanteMate.count') do
      post :create, participante_mate: @participante_mate.attributes
    end

    assert_redirected_to participante_mate_path(assigns(:participante_mate))
  end

  test "should show participante_mate" do
    get :show, id: @participante_mate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participante_mate.to_param
    assert_response :success
  end

  test "should update participante_mate" do
    put :update, id: @participante_mate.to_param, participante_mate: @participante_mate.attributes
    assert_redirected_to participante_mate_path(assigns(:participante_mate))
  end

  test "should destroy participante_mate" do
    assert_difference('ParticipanteMate.count', -1) do
      delete :destroy, id: @participante_mate.to_param
    end

    assert_redirected_to participantes_mates_path
  end
end
