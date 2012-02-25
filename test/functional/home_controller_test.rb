require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get inicio" do
    get :inicio
    assert_response :success
  end

  test "should get academico" do
    get :academico
    assert_response :success
  end

  test "should get patrocinio" do
    get :patrocinio
    assert_response :success
  end

end
