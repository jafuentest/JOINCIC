require 'test_helper'

class MaterialesPopControllerTest < ActionController::TestCase
  setup do
    @material_pop = materiales_pop(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:materiales_pop)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_pop" do
    assert_difference('MaterialPop.count') do
      post :create, material_pop: @material_pop.attributes
    end

    assert_redirected_to material_pop_path(assigns(:material_pop))
  end

  test "should show material_pop" do
    get :show, id: @material_pop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material_pop.to_param
    assert_response :success
  end

  test "should update material_pop" do
    put :update, id: @material_pop.to_param, material_pop: @material_pop.attributes
    assert_redirected_to material_pop_path(assigns(:material_pop))
  end

  test "should destroy material_pop" do
    assert_difference('MaterialPop.count', -1) do
      delete :destroy, id: @material_pop.to_param
    end

    assert_redirected_to materiales_pop_path
  end
end
