require 'test_helper'

class StockChartsControllerTest < ActionController::TestCase
  setup do
    @stock_chart = stock_charts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_charts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_chart" do
    assert_difference('StockChart.count') do
      post :create, stock_chart: {  }
    end

    assert_redirected_to stock_chart_path(assigns(:stock_chart))
  end

  test "should show stock_chart" do
    get :show, id: @stock_chart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stock_chart
    assert_response :success
  end

  test "should update stock_chart" do
    put :update, id: @stock_chart, stock_chart: {  }
    assert_redirected_to stock_chart_path(assigns(:stock_chart))
  end

  test "should destroy stock_chart" do
    assert_difference('StockChart.count', -1) do
      delete :destroy, id: @stock_chart
    end

    assert_redirected_to stock_charts_path
  end
end
