require 'test_helper'

class FlipFlopsControllerTest < ActionController::TestCase
  setup do
    @flip_flop = flip_flops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flip_flops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flip_flop" do
    assert_difference('FlipFlop.count') do
      post :create, flip_flop: @flip_flop.attributes
    end

    assert_redirected_to flip_flop_path(assigns(:flip_flop))
  end

  test "should show flip_flop" do
    get :show, id: @flip_flop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flip_flop.to_param
    assert_response :success
  end

  test "should update flip_flop" do
    put :update, id: @flip_flop.to_param, flip_flop: @flip_flop.attributes
    assert_redirected_to flip_flop_path(assigns(:flip_flop))
  end

  test "should destroy flip_flop" do
    assert_difference('FlipFlop.count', -1) do
      delete :destroy, id: @flip_flop.to_param
    end

    assert_redirected_to flip_flops_path
  end
end
