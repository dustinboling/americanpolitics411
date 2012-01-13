require 'test_helper'

class ContributorsInterestGroupsControllerTest < ActionController::TestCase
  setup do
    @contributors_interest_group = contributors_interest_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contributors_interest_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contributors_interest_group" do
    assert_difference('ContributorsInterestGroup.count') do
      post :create, contributors_interest_group: @contributors_interest_group.attributes
    end

    assert_redirected_to contributors_interest_group_path(assigns(:contributors_interest_group))
  end

  test "should show contributors_interest_group" do
    get :show, id: @contributors_interest_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contributors_interest_group.to_param
    assert_response :success
  end

  test "should update contributors_interest_group" do
    put :update, id: @contributors_interest_group.to_param, contributors_interest_group: @contributors_interest_group.attributes
    assert_redirected_to contributors_interest_group_path(assigns(:contributors_interest_group))
  end

  test "should destroy contributors_interest_group" do
    assert_difference('ContributorsInterestGroup.count', -1) do
      delete :destroy, id: @contributors_interest_group.to_param
    end

    assert_redirected_to contributors_interest_groups_path
  end
end
