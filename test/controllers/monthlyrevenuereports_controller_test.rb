require 'test_helper'

class MonthlyrevenuereportsControllerTest < ActionController::TestCase
  setup do
    @monthlyrevenuereport = monthlyrevenuereports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monthlyrevenuereports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monthlyrevenuereport" do
    assert_difference('Monthlyrevenuereport.count') do
      post :create, monthlyrevenuereport: { fiscal_year: @monthlyrevenuereport.fiscal_year }
    end

    assert_redirected_to monthlyrevenuereport_path(assigns(:monthlyrevenuereport))
  end

  test "should show monthlyrevenuereport" do
    get :show, id: @monthlyrevenuereport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @monthlyrevenuereport
    assert_response :success
  end

  test "should update monthlyrevenuereport" do
    patch :update, id: @monthlyrevenuereport, monthlyrevenuereport: { fiscal_year: @monthlyrevenuereport.fiscal_year }
    assert_redirected_to monthlyrevenuereport_path(assigns(:monthlyrevenuereport))
  end

  test "should destroy monthlyrevenuereport" do
    assert_difference('Monthlyrevenuereport.count', -1) do
      delete :destroy, id: @monthlyrevenuereport
    end

    assert_redirected_to monthlyrevenuereports_path
  end
end
