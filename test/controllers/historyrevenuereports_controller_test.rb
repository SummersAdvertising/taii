require 'test_helper'

class HistoryrevenuereportsControllerTest < ActionController::TestCase
  setup do
    @historyrevenuereport = historyrevenuereports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historyrevenuereports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historyrevenuereport" do
    assert_difference('Historyrevenuereport.count') do
      post :create, historyrevenuereport: { fiscal_year: @historyrevenuereport.fiscal_year }
    end

    assert_redirected_to historyrevenuereport_path(assigns(:historyrevenuereport))
  end

  test "should show historyrevenuereport" do
    get :show, id: @historyrevenuereport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historyrevenuereport
    assert_response :success
  end

  test "should update historyrevenuereport" do
    patch :update, id: @historyrevenuereport, historyrevenuereport: { fiscal_year: @historyrevenuereport.fiscal_year }
    assert_redirected_to historyrevenuereport_path(assigns(:historyrevenuereport))
  end

  test "should destroy historyrevenuereport" do
    assert_difference('Historyrevenuereport.count', -1) do
      delete :destroy, id: @historyrevenuereport
    end

    assert_redirected_to historyrevenuereports_path
  end
end
