require 'test_helper'

class HqlevelsControllerTest < ActionController::TestCase
  setup do
    @hqlevel = hqlevels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hqlevels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hqlevel" do
    assert_difference('Hqlevel.count') do
      post :create, hqlevel: { level: @hqlevel.level, name: @hqlevel.name, parent: @hqlevel.parent }
    end

    assert_redirected_to hqlevel_path(assigns(:hqlevel))
  end

  test "should show hqlevel" do
    get :show, id: @hqlevel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hqlevel
    assert_response :success
  end

  test "should update hqlevel" do
    patch :update, id: @hqlevel, hqlevel: { level: @hqlevel.level, name: @hqlevel.name, parent: @hqlevel.parent }
    assert_redirected_to hqlevel_path(assigns(:hqlevel))
  end

  test "should destroy hqlevel" do
    assert_difference('Hqlevel.count', -1) do
      delete :destroy, id: @hqlevel
    end

    assert_redirected_to hqlevels_path
  end
end
