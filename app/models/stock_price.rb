class StockPrice  < ActiveResource::Base
  self.site = "http://ichart.finance.yahoo.com"
  self.element_name = "table"
  self.collection_name="table"
  self.include_root_in_json = false

  #"?s=WU&a=01&b=19&c=2010&d=01&e=19&f=2010&g=d&ignore=.csv"
  # http://ichart.finance.yahoo.com/table.csv?s=AAPL&a=10&b=19&c=2000&d=11&e=19&f=2000&g=d&ignore=.csv
  # a - month (0=Jan)
  self.format= ActiveResource::Formats::CsvFormat

  class << self
    def query_string(options)
      "?#{hash_to_query(options)}" unless options.nil? || options.empty?
    end

    def hash_to_query(options)
      options.collect do |key, value|
        value.to_query(key)
      end * '&'
    end
  end


  def self.find_historical_price(symbol, date_range, interval = :daily)
    start_at = date_range.begin
    end_at = date_range.end


    self.find(:all, :params => {
        s: symbol,
        a: ((start_at.month - 1)),
        b: start_at.day,
        c: start_at.year,
        d: ((end_at.month - 1)),
        e: end_at.day,
        f: end_at.year,
        g: 'd',
        ignore: '.csv'
    })
  end


  def to_json(options = {})
    [
=begin
        Col 0: String (discrete) used as a group label on the X axis, or number, date, datetime or timeofday (continuous) used as a value on the X axis.
        Col 1: Number specifying the low/minimum value of this marker. This is the base of the candle's center line. The column label is used as the series label in the legend (while the labels of the other columns are ignored).
        Col 2: Number specifying the opening/initial value of this marker. This is one vertical border of the candle. If less than the column 3 value, the candle will be filled; otherwise it will be hollow.
        Col 3: Number specifying the closing/final value of this marker. This is the second vertical border of the candle. If less than the column 2 value, the candle will be hollow; otherwise it will be filled.
        Col 4: Number specifying the high/maximum value of this marker. This is the top of the candle's center line.
                                                                                                                                                                                                                                                                                                                                                                Col 5 [Optional]: A tooltip for the candlestick.
=end
        self.date,
        self.low,
        self.open,
        self.close,
        self.high
    ].to_json(options)
  end

end

