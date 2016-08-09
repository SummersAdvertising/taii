require 'test_helper'

class DividendHistoriesControllerTest < ActionController::TestCase
  setup do
    @dividend_history = dividend_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dividend_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dividend_history" do
    assert_difference('DividendHistory.count') do
      post :create, dividend_history: { cash: @dividend_history.cash, cash_paymentdate: @dividend_history.cash_paymentdate, fiscal_year: @dividend_history.fiscal_year, scap: @dividend_history.scap, sre: @dividend_history.sre, stock_paymentdate: @dividend_history.stock_paymentdate, total: @dividend_history.total }
    end

    assert_redirected_to dividend_history_path(assigns(:dividend_history))
  end

  test "should show dividend_history" do
    get :show, id: @dividend_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dividend_history
    assert_response :success
  end

  test "should update dividend_history" do
    patch :update, id: @dividend_history, dividend_history: { cash: @dividend_history.cash, cash_paymentdate: @dividend_history.cash_paymentdate, fiscal_year: @dividend_history.fiscal_year, scap: @dividend_history.scap, sre: @dividend_history.sre, stock_paymentdate: @dividend_history.stock_paymentdate, total: @dividend_history.total }
    assert_redirected_to dividend_history_path(assigns(:dividend_history))
  end

  test "should destroy dividend_history" do
    assert_difference('DividendHistory.count', -1) do
      delete :destroy, id: @dividend_history
    end

    assert_redirected_to dividend_histories_path
  end
end
