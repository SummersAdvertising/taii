require 'test_helper'

class BrlevelsControllerTest < ActionController::TestCase
  setup do
    @brlevel = brlevels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brlevels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brlevel" do
    assert_difference('Brlevel.count') do
      post :create, brlevel: { level: @brlevel.level, name: @brlevel.name, parent: @brlevel.parent }
    end

    assert_redirected_to brlevel_path(assigns(:brlevel))
  end

  test "should show brlevel" do
    get :show, id: @brlevel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brlevel
    assert_response :success
  end

  test "should update brlevel" do
    patch :update, id: @brlevel, brlevel: { level: @brlevel.level, name: @brlevel.name, parent: @brlevel.parent }
    assert_redirected_to brlevel_path(assigns(:brlevel))
  end

  test "should destroy brlevel" do
    assert_difference('Brlevel.count', -1) do
      delete :destroy, id: @brlevel
    end

    assert_redirected_to brlevels_path
  end
end
