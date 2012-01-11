require 'test_helper'

class ProfessionalExperiencesControllerTest < ActionController::TestCase
  setup do
    @professional_experience = professional_experiences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:professional_experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create professional_experience" do
    assert_difference('ProfessionalExperience.count') do
      post :create, professional_experience: @professional_experience.attributes
    end

    assert_redirected_to professional_experience_path(assigns(:professional_experience))
  end

  test "should show professional_experience" do
    get :show, id: @professional_experience.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @professional_experience.to_param
    assert_response :success
  end

  test "should update professional_experience" do
    put :update, id: @professional_experience.to_param, professional_experience: @professional_experience.attributes
    assert_redirected_to professional_experience_path(assigns(:professional_experience))
  end

  test "should destroy professional_experience" do
    assert_difference('ProfessionalExperience.count', -1) do
      delete :destroy, id: @professional_experience.to_param
    end

    assert_redirected_to professional_experiences_path
  end
end
