class StockPricesController < ApplicationController

  # GET /stock_price/1.json
  def show
    logger.info("param=#{params}")

    symbol = params[:id]
    #date_range = Date.today..(Date.today - 5)
    date_range = Date.parse('2000-11-19')..Date.parse('2000-12-19')

    @stock_prices = StockPrice.find_historical_price(symbol, date_range)

    logger.info("prices=#{@stock_prices}")

    respond_to do |format|
      format.json { render json: @stock_prices }
    end
  end

end