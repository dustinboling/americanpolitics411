require 'test_helper'

class BusinessAssociatesControllerTest < ActionController::TestCase
  setup do
    @business_associate = business_associates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_associates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_associate" do
    assert_difference('BusinessAssociate.count') do
      post :create, business_associate: @business_associate.attributes
    end

    assert_redirected_to business_associate_path(assigns(:business_associate))
  end

  test "should show business_associate" do
    get :show, id: @business_associate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_associate.to_param
    assert_response :success
  end

  test "should update business_associate" do
    put :update, id: @business_associate.to_param, business_associate: @business_associate.attributes
    assert_redirected_to business_associate_path(assigns(:business_associate))
  end

  test "should destroy business_associate" do
    assert_difference('BusinessAssociate.count', -1) do
      delete :destroy, id: @business_associate.to_param
    end

    assert_redirected_to business_associates_path
  end
end
