require 'spec_helper'

describe StockPrice do
  # NOTE: before only applies to the siblings of the same example group
  before(:each) do
    @prices = (1..2).collect { FactoryGirl.build(:stock_price) }
  end

  # NOTE: subject only applies to descendents of the parent example group
  subject(:prices) { @prices }

  it { should_not be_empty }

  context "should have the proper field" do
    subject(:price) { prices[0] }

    its(:date) { should == '2000-12-19' }
    its('low.to_f')   { should == 14.00 }
    # open is kernel method
    specify { price.open.to_f.should == 14.38 }
    its('close.to_f') { should == 14.00 }
    its('high.to_f')  { should == 15.25 }
  end
end
