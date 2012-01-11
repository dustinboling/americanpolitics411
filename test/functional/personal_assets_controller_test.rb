require 'test_helper'

class PersonalAssetsControllerTest < ActionController::TestCase
  setup do
    @personal_asset = personal_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_asset" do
    assert_difference('PersonalAsset.count') do
      post :create, personal_asset: @personal_asset.attributes
    end

    assert_redirected_to personal_asset_path(assigns(:personal_asset))
  end

  test "should show personal_asset" do
    get :show, id: @personal_asset.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_asset.to_param
    assert_response :success
  end

  test "should update personal_asset" do
    put :update, id: @personal_asset.to_param, personal_asset: @personal_asset.attributes
    assert_redirected_to personal_asset_path(assigns(:personal_asset))
  end

  test "should destroy personal_asset" do
    assert_difference('PersonalAsset.count', -1) do
      delete :destroy, id: @personal_asset.to_param
    end

    assert_redirected_to personal_assets_path
  end
end
