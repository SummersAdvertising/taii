require 'test_helper'

class FinancialprojectionsControllerTest < ActionController::TestCase
  setup do
    @financialprojection = financialprojections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:financialprojections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create financialprojection" do
    assert_difference('Financialprojection.count') do
      post :create, financialprojection: { article_id: @financialprojection.article_id, title: @financialprojection.title }
    end

    assert_redirected_to financialprojection_path(assigns(:financialprojection))
  end

  test "should show financialprojection" do
    get :show, id: @financialprojection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @financialprojection
    assert_response :success
  end

  test "should update financialprojection" do
    patch :update, id: @financialprojection, financialprojection: { article_id: @financialprojection.article_id, title: @financialprojection.title }
    assert_redirected_to financialprojection_path(assigns(:financialprojection))
  end

  test "should destroy financialprojection" do
    assert_difference('Financialprojection.count', -1) do
      delete :destroy, id: @financialprojection
    end

    assert_redirected_to financialprojections_path
  end
end
