class StockChartQuery
  include ActiveAttr::Model

  attribute :symbol, :type => String
  attribute :start_date, :type => Date
  attribute :end_date, :type => Date

  attr_accessor :symbol, :start_date, :end_date

  validates :symbol,   :presence => true

  validates_date :start_date,
                 if: "end_date",   # mutual inclusive or exclusive with start_date
                 before: lambda{ Date.today }, before_message: "must be a date in the past"

  validates_date :end_date,
                 if: "start_date", # mutual inclusive or exclusive with end_date
                 before: lambda{ Date.today }, before_message: "must be a date in the past",
                 on_or_after: :start_date, on_or_after_message: "must be on or after start date"


  def initialize(attrs = {} )
    attrs.each do |name, value|
      # calling the attr accessor
      self.send("#{name}=", value) if self.respond_to? "#{name}="
    end
  end

  def persisted?
    false
  end

  def attributes
    {
        symbol: symbol,
        start_date: start_date,
        end_date: end_date
    }
  end
end