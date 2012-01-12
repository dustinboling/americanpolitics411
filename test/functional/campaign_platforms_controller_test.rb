require 'test_helper'

class CampaignPlatformsControllerTest < ActionController::TestCase
  setup do
    @campaign_platform = campaign_platforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campaign_platforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign_platform" do
    assert_difference('CampaignPlatform.count') do
      post :create, campaign_platform: @campaign_platform.attributes
    end

    assert_redirected_to campaign_platform_path(assigns(:campaign_platform))
  end

  test "should show campaign_platform" do
    get :show, id: @campaign_platform.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign_platform.to_param
    assert_response :success
  end

  test "should update campaign_platform" do
    put :update, id: @campaign_platform.to_param, campaign_platform: @campaign_platform.attributes
    assert_redirected_to campaign_platform_path(assigns(:campaign_platform))
  end

  test "should destroy campaign_platform" do
    assert_difference('CampaignPlatform.count', -1) do
      delete :destroy, id: @campaign_platform.to_param
    end

    assert_redirected_to campaign_platforms_path
  end
end
