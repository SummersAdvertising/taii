require 'test_helper'

class BrproductsControllerTest < ActionController::TestCase
  setup do
    @brproduct = brproducts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brproducts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brproduct" do
    assert_difference('Brproduct.count') do
      post :create, brproduct: { article_id: @brproduct.article_id, brlevel_id: @brproduct.brlevel_id, name: @brproduct.name }
    end

    assert_redirected_to brproduct_path(assigns(:brproduct))
  end

  test "should show brproduct" do
    get :show, id: @brproduct
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brproduct
    assert_response :success
  end

  test "should update brproduct" do
    patch :update, id: @brproduct, brproduct: { article_id: @brproduct.article_id, brlevel_id: @brproduct.brlevel_id, name: @brproduct.name }
    assert_redirected_to brproduct_path(assigns(:brproduct))
  end

  test "should destroy brproduct" do
    assert_difference('Brproduct.count', -1) do
      delete :destroy, id: @brproduct
    end

    assert_redirected_to brproducts_path
  end
end
