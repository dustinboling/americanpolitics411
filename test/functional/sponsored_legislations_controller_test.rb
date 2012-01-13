require 'test_helper'

class SponsoredLegislationsControllerTest < ActionController::TestCase
  setup do
    @sponsored_legislation = sponsored_legislations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsored_legislations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsored_legislation" do
    assert_difference('SponsoredLegislation.count') do
      post :create, sponsored_legislation: @sponsored_legislation.attributes
    end

    assert_redirected_to sponsored_legislation_path(assigns(:sponsored_legislation))
  end

  test "should show sponsored_legislation" do
    get :show, id: @sponsored_legislation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sponsored_legislation.to_param
    assert_response :success
  end

  test "should update sponsored_legislation" do
    put :update, id: @sponsored_legislation.to_param, sponsored_legislation: @sponsored_legislation.attributes
    assert_redirected_to sponsored_legislation_path(assigns(:sponsored_legislation))
  end

  test "should destroy sponsored_legislation" do
    assert_difference('SponsoredLegislation.count', -1) do
      delete :destroy, id: @sponsored_legislation.to_param
    end

    assert_redirected_to sponsored_legislations_path
  end
end
