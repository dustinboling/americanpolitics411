require 'test_helper'

class ContributorsPacsControllerTest < ActionController::TestCase
  setup do
    @contributors_pac = contributors_pacs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contributors_pacs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contributors_pac" do
    assert_difference('ContributorsPac.count') do
      post :create, contributors_pac: @contributors_pac.attributes
    end

    assert_redirected_to contributors_pac_path(assigns(:contributors_pac))
  end

  test "should show contributors_pac" do
    get :show, id: @contributors_pac.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contributors_pac.to_param
    assert_response :success
  end

  test "should update contributors_pac" do
    put :update, id: @contributors_pac.to_param, contributors_pac: @contributors_pac.attributes
    assert_redirected_to contributors_pac_path(assigns(:contributors_pac))
  end

  test "should destroy contributors_pac" do
    assert_difference('ContributorsPac.count', -1) do
      delete :destroy, id: @contributors_pac.to_param
    end

    assert_redirected_to contributors_pacs_path
  end
end
