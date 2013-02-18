require 'spec_helper'

describe "goto_stock_chart" do

  it "should handle post request with stock_chart_query parameter object" do
    @routing_parameter = {
        symbol: 'AAPL',
        start_date: '2002-11-19',
        end_date: '2002-12-19'
    }

    post "/goto_stock_chart", stock_chart_query: @routing_parameter
    response.should redirect_to("/stock_charts/#{@routing_parameter[:symbol]}?#{@routing_parameter.to_query(:stock_chart_query)}")

  end

end