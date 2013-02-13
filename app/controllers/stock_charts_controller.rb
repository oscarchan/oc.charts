class StockChartsController < ApplicationController

  # GET /stock_charts
  # GET /stock_charts.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stock_charts }
    end
  end

  # GET /stock_charts/1
  # GET /stock_charts/1.json
  def show
    logger.info("param=#{params}")

    @id = params[:id]
    @stock_price_params = params.slice(:start_date, :end_date)

    if @id.blank?
      logger.warn("missing symbol")
      flash[:error] = 'missing stock symbol'
      redirect_to :action => 'index'
      return 
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock_chart }
    end
  end

  # GET /stock_charts/new
  # GET /stock_charts/new.json
=begin
  def new
    @stock_chart = StockChart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stock_chart }
    end
  end
=end

  # GET /stock_charts/1/edit
=begin
  def edit
    @stock_chart = StockChart.find(params[:id])
  end
=end

  # POST /sto0ck_charts
  # POST /stock_charts.json
=begin
  def create
    @stock_chart = StockChart.new(params[:stock_chart])

    respond_to do |format|
      if @stock_chart.save
        format.html { redirect_to @stock_chart, notice: 'Stock chart was successfully created.' }
        format.json { render json: @stock_chart, status: :created, location: @stock_chart }
      else
        format.html { render action: "new" }
        format.json { render json: @stock_chart.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # PUT /stock_charts/1
  # PUT /stock_charts/1.json
=begin
  def update
    @stock_chart = StockChart.find(params[:id])

    respond_to do |format|
      if @stock_chart.update_attributes(params[:stock_chart])
        format.html { redirect_to @stock_chart, notice: 'Stock chart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stock_chart.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /stock_charts/1
  # DELETE /stock_charts/1.json
=begin
  def destroy
    @stock_chart = StockChart.find(params[:id])
    @stock_chart.destroy

    respond_to do |format|
      format.html { redirect_to stock_charts_url }
      format.json { head :no_content }
    end
  end
=end
end
