require 'test_helper'

class RevenueItemsControllerTest < ActionController::TestCase
  setup do
    @revenue_item = revenue_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:revenue_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create revenue_item" do
    assert_difference('RevenueItem.count') do
      post :create, revenue_item: { fiscal_month: @revenue_item.fiscal_month, item: @revenue_item.item, ranking: @revenue_item.ranking, value: @revenue_item.value }
    end

    assert_redirected_to revenue_item_path(assigns(:revenue_item))
  end

  test "should show revenue_item" do
    get :show, id: @revenue_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @revenue_item
    assert_response :success
  end

  test "should update revenue_item" do
    patch :update, id: @revenue_item, revenue_item: { fiscal_month: @revenue_item.fiscal_month, item: @revenue_item.item, ranking: @revenue_item.ranking, value: @revenue_item.value }
    assert_redirected_to revenue_item_path(assigns(:revenue_item))
  end

  test "should destroy revenue_item" do
    assert_difference('RevenueItem.count', -1) do
      delete :destroy, id: @revenue_item
    end

    assert_redirected_to revenue_items_path
  end
end
