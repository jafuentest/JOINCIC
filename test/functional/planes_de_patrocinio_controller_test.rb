require 'test_helper'

class PlanesDePatrocinioControllerTest < ActionController::TestCase
  setup do
    @plan_de_patrocinio = planes_de_patrocinio(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planes_de_patrocinio)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plan_de_patrocinio" do
    assert_difference('PlanDePatrocinio.count') do
      post :create, plan_de_patrocinio: @plan_de_patrocinio.attributes
    end

    assert_redirected_to plan_de_patrocinio_path(assigns(:plan_de_patrocinio))
  end

  test "should show plan_de_patrocinio" do
    get :show, id: @plan_de_patrocinio.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plan_de_patrocinio.to_param
    assert_response :success
  end

  test "should update plan_de_patrocinio" do
    put :update, id: @plan_de_patrocinio.to_param, plan_de_patrocinio: @plan_de_patrocinio.attributes
    assert_redirected_to plan_de_patrocinio_path(assigns(:plan_de_patrocinio))
  end

  test "should destroy plan_de_patrocinio" do
    assert_difference('PlanDePatrocinio.count', -1) do
      delete :destroy, id: @plan_de_patrocinio.to_param
    end

    assert_redirected_to planes_de_patrocinio_path
  end
end
