require 'spec_helper'

describe StockChartQuery do
  before(:each) do
    @params = {
        symbol: 'AAPL',
        start_date: '2013-01-01',
        end_date: '2013-01-31'
    }
  end

  subject (:form) { StockChartQuery.new(@params) }

  it "should accept a full valid form" do
    should be_valid
  end

  context "should reject missing symbol" do
    before(:each) { form.symbol = nil }

    it { should_not be_valid }
    it { should have(1).error_on(:symbol) }
  end

  context "start and end dates " do
    it "should accept when both are missing" do
      form.start_date = nil
      form.end_date = nil

      should be_valid
    end

    context "should not be accepted " do
      [:start_date, :end_date].each do |attr|
        context "when #{attr} is the only one missing" do
          before(:each) { form.send("#{attr}=", nil) }

          it { should_not be_valid }
          it { should have(1).error_on(attr) }
        end
      end
    end

    context "should not be accepted when they are current or future dates" do
      before(:each) {
        form.start_date = (Date.tomorrow).to_s
        form.end_date = (Date.tomorrow + 1).to_s
      }

      it { should_not be_valid }
      it { should have(1).error_on(:start_date)}
      it { should have(1).error_on(:end_date)}
    end

    context "should be a valid range" do
      before(:each) {
        form.start_date = (Date.yesterday).to_s
        form.end_date = (Date.yesterday - 1).to_s
      }

      it { should_not be_valid }
      it { should have(1).error_on(:end_date)}
    end

  end
end
