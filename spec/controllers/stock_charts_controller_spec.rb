require 'spec_helper'

describe StockChartsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should be redirect" do
      get '/goto_stock_chart'
      response.should be_success
    end
  end
end