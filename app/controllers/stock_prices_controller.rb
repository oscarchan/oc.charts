class StockPricesController < ApplicationController

  # GET /stock_price/1.json
  def show
    logger.info("param=#{params}")

    symbol = params[:id]
    start_date = params[:start_date]
    end_date = params[:end_date]
    date_range = (Date.today - 30)..(Date.today - 1)
    logger.info("date_range1=#{date_range}")

    @stock_prices = StockPrice.find_historical_price(symbol, date_range)

    logger.info("prices=#{@stock_prices}")

    respond_to do |format|
      format.json { render json: @stock_prices }
    end
  end

end