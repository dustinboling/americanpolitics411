require 'test_helper'

class LitigationsControllerTest < ActionController::TestCase
  setup do
    @litigation = litigations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:litigations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create litigation" do
    assert_difference('Litigation.count') do
      post :create, litigation: @litigation.attributes
    end

    assert_redirected_to litigation_path(assigns(:litigation))
  end

  test "should show litigation" do
    get :show, id: @litigation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @litigation.to_param
    assert_response :success
  end

  test "should update litigation" do
    put :update, id: @litigation.to_param, litigation: @litigation.attributes
    assert_redirected_to litigation_path(assigns(:litigation))
  end

  test "should destroy litigation" do
    assert_difference('Litigation.count', -1) do
      delete :destroy, id: @litigation.to_param
    end

    assert_redirected_to litigations_path
  end
end
