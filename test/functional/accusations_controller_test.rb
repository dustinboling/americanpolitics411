require 'test_helper'

class AccusationsControllerTest < ActionController::TestCase
  setup do
    @accusation = accusations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accusations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accusation" do
    assert_difference('Accusation.count') do
      post :create, accusation: @accusation.attributes
    end

    assert_redirected_to accusation_path(assigns(:accusation))
  end

  test "should show accusation" do
    get :show, id: @accusation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accusation.to_param
    assert_response :success
  end

  test "should update accusation" do
    put :update, id: @accusation.to_param, accusation: @accusation.attributes
    assert_redirected_to accusation_path(assigns(:accusation))
  end

  test "should destroy accusation" do
    assert_difference('Accusation.count', -1) do
      delete :destroy, id: @accusation.to_param
    end

    assert_redirected_to accusations_path
  end
end
