require 'test_helper'

class EarmarksControllerTest < ActionController::TestCase
  setup do
    @earmark = earmarks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:earmarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create earmark" do
    assert_difference('Earmark.count') do
      post :create, earmark: @earmark.attributes
    end

    assert_redirected_to earmark_path(assigns(:earmark))
  end

  test "should show earmark" do
    get :show, id: @earmark.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @earmark.to_param
    assert_response :success
  end

  test "should update earmark" do
    put :update, id: @earmark.to_param, earmark: @earmark.attributes
    assert_redirected_to earmark_path(assigns(:earmark))
  end

  test "should destroy earmark" do
    assert_difference('Earmark.count', -1) do
      delete :destroy, id: @earmark.to_param
    end

    assert_redirected_to earmarks_path
  end
end
