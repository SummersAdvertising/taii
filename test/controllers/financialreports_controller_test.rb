require 'test_helper'

class FinancialreportsControllerTest < ActionController::TestCase
  setup do
    @financialreport = financialreports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:financialreports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create financialreport" do
    assert_difference('Financialreport.count') do
      post :create, financialreport: { fiscal_year: @financialreport.fiscal_year }
    end

    assert_redirected_to financialreport_path(assigns(:financialreport))
  end

  test "should show financialreport" do
    get :show, id: @financialreport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @financialreport
    assert_response :success
  end

  test "should update financialreport" do
    patch :update, id: @financialreport, financialreport: { fiscal_year: @financialreport.fiscal_year }
    assert_redirected_to financialreport_path(assigns(:financialreport))
  end

  test "should destroy financialreport" do
    assert_difference('Financialreport.count', -1) do
      delete :destroy, id: @financialreport
    end

    assert_redirected_to financialreports_path
  end
end
