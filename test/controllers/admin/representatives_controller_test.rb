require 'test_helper'

class Admin::RepresentativesControllerTest < ActionController::TestCase
  setup do
    @admin_representative = admin_representatives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_representatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_representative" do
    assert_difference('Admin::Representative.count') do
      post :create, admin_representative: {  }
    end

    assert_redirected_to admin_representative_path(assigns(:admin_representative))
  end

  test "should show admin_representative" do
    get :show, id: @admin_representative
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_representative
    assert_response :success
  end

  test "should update admin_representative" do
    patch :update, id: @admin_representative, admin_representative: {  }
    assert_redirected_to admin_representative_path(assigns(:admin_representative))
  end

  test "should destroy admin_representative" do
    assert_difference('Admin::Representative.count', -1) do
      delete :destroy, id: @admin_representative
    end

    assert_redirected_to admin_representatives_path
  end
end
