require 'test_helper'

class AnnualreportsControllerTest < ActionController::TestCase
  setup do
    @annualreport = annualreports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:annualreports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create annualreport" do
    assert_difference('Annualreport.count') do
      post :create, annualreport: { fiscal_year: @annualreport.fiscal_year }
    end

    assert_redirected_to annualreport_path(assigns(:annualreport))
  end

  test "should show annualreport" do
    get :show, id: @annualreport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @annualreport
    assert_response :success
  end

  test "should update annualreport" do
    patch :update, id: @annualreport, annualreport: { fiscal_year: @annualreport.fiscal_year }
    assert_redirected_to annualreport_path(assigns(:annualreport))
  end

  test "should destroy annualreport" do
    assert_difference('Annualreport.count', -1) do
      delete :destroy, id: @annualreport
    end

    assert_redirected_to annualreports_path
  end
end
