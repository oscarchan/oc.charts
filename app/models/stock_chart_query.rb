class StockChartQuery
  include ActiveModel::Validations
  include ActiveModel::MassAssignmentSecurity
  include ActiveModel::Conversion
  include ActiveModel::Serializers::JSON
  extend ActiveModel::Naming

  attr_accessor :symbol, :start_date, :end_date

  validates :symbol,   :presence => true
  validates :start_date, :presence => true, :if => "end_date"
  validates :end_date, :presence => true, :if => "start_date"

  validate :must_be_a_date_range
  validate :dates_must_be_in_the_past

  cattr_accessor(:logger) {  ActiveRecord::Base.logger }

  def dates_must_be_in_the_past()
    attrs = [:start_date, :end_date]
    attrs.each { |attr|
      value = self.send(attr)
      errors.add(attr, "only past dates are accepted") if value && value >= Date.today
    }
  end

  def must_be_a_date(*attrs)
    attrs.each do |attr|
      value = self.send(attr)
      errors.add(attr, "must be a date") if value && value.is_a?(Date)
    end
  end

  def must_be_a_date_range()
    attrs = [:start_date, :end_date]
    start_date_attr = attrs.shift
    end_date_attr = attrs.shift

    start_date = self.send(start_date_attr)
    end_date = self.send(end_date_attr)

    if end_date && start_date
      errors.add(:end_date_attr, "end date must be on or after start date: start date=#{start_date}; end date=#{end_date} ") if start_date >= end_date
    end
  end

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

  def start_date
    begin
      Date.parse(@start_date) unless @start_date.blank?
    rescue Exception => e
      logger.info("#{self}: unable to parse start_date: #{@start_date}: #{e}")
      nil
    end
  end

  def end_date
    begin
      Date.parse(@end_date) unless @end_date.blank?
    rescue Exeption => e
      logger.info("#{self}: unable to parse end_date: #{@end_date}: #{e}")
      nil
    end
  end
end