require 'test_helper'

class ContributorsInterestGroupSectorsControllerTest < ActionController::TestCase
  setup do
    @contributors_interest_group_sector = contributors_interest_group_sectors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contributors_interest_group_sectors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contributors_interest_group_sector" do
    assert_difference('ContributorsInterestGroupSector.count') do
      post :create, contributors_interest_group_sector: @contributors_interest_group_sector.attributes
    end

    assert_redirected_to contributors_interest_group_sector_path(assigns(:contributors_interest_group_sector))
  end

  test "should show contributors_interest_group_sector" do
    get :show, id: @contributors_interest_group_sector.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contributors_interest_group_sector.to_param
    assert_response :success
  end

  test "should update contributors_interest_group_sector" do
    put :update, id: @contributors_interest_group_sector.to_param, contributors_interest_group_sector: @contributors_interest_group_sector.attributes
    assert_redirected_to contributors_interest_group_sector_path(assigns(:contributors_interest_group_sector))
  end

  test "should destroy contributors_interest_group_sector" do
    assert_difference('ContributorsInterestGroupSector.count', -1) do
      delete :destroy, id: @contributors_interest_group_sector.to_param
    end

    assert_redirected_to contributors_interest_group_sectors_path
  end
end
