class StockChartsController < ApplicationController
  # GET /stock_charts
  # GET /stock_charts.json
  def index
    @stock_charts = StockChart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stock_charts }
    end
  end

  # GET /stock_charts/1
  # GET /stock_charts/1.json
  def show
    @stock_chart = StockChart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock_chart }
    end
  end

  # GET /stock_charts/new
  # GET /stock_charts/new.json
  def new
    @stock_chart = StockChart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stock_chart }
    end
  end

  # GET /stock_charts/1/edit
  def edit
    @stock_chart = StockChart.find(params[:id])
  end

  # POST /stock_charts
  # POST /stock_charts.json
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

  # PUT /stock_charts/1
  # PUT /stock_charts/1.json
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

  # DELETE /stock_charts/1
  # DELETE /stock_charts/1.json
  def destroy
    @stock_chart = StockChart.find(params[:id])
    @stock_chart.destroy

    respond_to do |format|
      format.html { redirect_to stock_charts_url }
      format.json { head :no_content }
    end
  end
end
