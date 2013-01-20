require 'spec_helper'

describe SearchHelper do
  helper SearchHelper

  describe "#prices" do
    before :each do
      @person = FactoryGirl.create(:learner)
    end
    
    it "shows one num when prices are the same" do
      @person.max_price = @person.min_price = 1
      prices(@person).should == "$#{@person.min_price}"
    end

    it "shows dash when prices are equal zero" do
      @person.min_price = @person.max_price = 0
      prices(@person).should == "&ndash;"
    end

    it "shows the price range" do
      @person.min_price = 2
      @person.max_price = 3
      prices(@person).should == "$#{@person.min_price} &ndash; $#{@person.max_price}"
    end
  end

  describe "#langs" do
    before :each do
      @person = FactoryGirl.create(:learner)
    end
    
    it "shows all langs" do
      @person.languages = [FactoryGirl.create(:language, name: 'test1'), FactoryGirl.create(:language, name: 'test2')]
      langs(@person).should == 'test1, test2'
    end

    it "shows dash when no langs" do
      @person.languages = []
      langs(@person).should == '&ndash;'
    end
  end

end