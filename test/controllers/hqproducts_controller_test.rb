require 'test_helper'

class HqproductsControllerTest < ActionController::TestCase
  setup do
    @hqproduct = hqproducts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hqproducts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hqproduct" do
    assert_difference('Hqproduct.count') do
      post :create, hqproduct: { article_id: @hqproduct.article_id, hqlevel_id: @hqproduct.hqlevel_id, name: @hqproduct.name }
    end

    assert_redirected_to hqproduct_path(assigns(:hqproduct))
  end

  test "should show hqproduct" do
    get :show, id: @hqproduct
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hqproduct
    assert_response :success
  end

  test "should update hqproduct" do
    patch :update, id: @hqproduct, hqproduct: { article_id: @hqproduct.article_id, hqlevel_id: @hqproduct.hqlevel_id, name: @hqproduct.name }
    assert_redirected_to hqproduct_path(assigns(:hqproduct))
  end

  test "should destroy hqproduct" do
    assert_difference('Hqproduct.count', -1) do
      delete :destroy, id: @hqproduct
    end

    assert_redirected_to hqproducts_path
  end
end
