require 'test_helper'

class PoliticalOfficesControllerTest < ActionController::TestCase
  setup do
    @political_office = political_offices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:political_offices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create political_office" do
    assert_difference('PoliticalOffice.count') do
      post :create, political_office: @political_office.attributes
    end

    assert_redirected_to political_office_path(assigns(:political_office))
  end

  test "should show political_office" do
    get :show, id: @political_office.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @political_office.to_param
    assert_response :success
  end

  test "should update political_office" do
    put :update, id: @political_office.to_param, political_office: @political_office.attributes
    assert_redirected_to political_office_path(assigns(:political_office))
  end

  test "should destroy political_office" do
    assert_difference('PoliticalOffice.count', -1) do
      delete :destroy, id: @political_office.to_param
    end

    assert_redirected_to political_offices_path
  end
end
