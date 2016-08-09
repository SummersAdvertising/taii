require 'test_helper'

class MajorpoliciesControllerTest < ActionController::TestCase
  setup do
    @majorpolicy = majorpolicies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:majorpolicies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create majorpolicy" do
    assert_difference('Majorpolicy.count') do
      post :create, majorpolicy: { description: @majorpolicy.description }
    end

    assert_redirected_to majorpolicy_path(assigns(:majorpolicy))
  end

  test "should show majorpolicy" do
    get :show, id: @majorpolicy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @majorpolicy
    assert_response :success
  end

  test "should update majorpolicy" do
    patch :update, id: @majorpolicy, majorpolicy: { description: @majorpolicy.description }
    assert_redirected_to majorpolicy_path(assigns(:majorpolicy))
  end

  test "should destroy majorpolicy" do
    assert_difference('Majorpolicy.count', -1) do
      delete :destroy, id: @majorpolicy
    end

    assert_redirected_to majorpolicies_path
  end
end
