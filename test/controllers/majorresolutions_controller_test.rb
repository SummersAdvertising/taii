require 'test_helper'

class MajorresolutionsControllerTest < ActionController::TestCase
  setup do
    @majorresolution = majorresolutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:majorresolutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create majorresolution" do
    assert_difference('Majorresolution.count') do
      post :create, majorresolution: { fiscal_year: @majorresolution.fiscal_year }
    end

    assert_redirected_to majorresolution_path(assigns(:majorresolution))
  end

  test "should show majorresolution" do
    get :show, id: @majorresolution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @majorresolution
    assert_response :success
  end

  test "should update majorresolution" do
    patch :update, id: @majorresolution, majorresolution: { fiscal_year: @majorresolution.fiscal_year }
    assert_redirected_to majorresolution_path(assigns(:majorresolution))
  end

  test "should destroy majorresolution" do
    assert_difference('Majorresolution.count', -1) do
      delete :destroy, id: @majorresolution
    end

    assert_redirected_to majorresolutions_path
  end
end
