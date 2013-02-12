require 'spec_helper'

describe StockPrice do
  # NOTE: before only applies to the siblings of the same example group
  before(:each) do
    @prices = (1..2).collect { FactoryGirl.build(:stock_price) }
  end

  # NOTE: subject only applies to descendents of the parent example group
  subject(:prices) { @prices }

  it { should_not be_empty }

  context "should have the proper attributes" do
    subject(:price) { prices[0] }

    its(:date) { should == '2000-12-19' }
    its('low')   { should == 14.00 }
    # open is kernel method unless explicitly overridden
    # specify { price.open.should == 14.38 }
    its('open') { should == 14.38 }
    its('close') { should == 14.00 }
    its('high')  { should == 15.25 }
  end

  context "should transform to the right proper json" do
    subject(:price) { prices[0] }

    its("to_json") { should == [price.date, price.low, price.open, price.close, price.high].to_json}
    its("to_json") { should == ['2000-12-19', 14.00, 14.38, 14.00, 15.25].to_json}

  end
end
