require 'spec_helper'

describe Search do

  describe "#get_count" do
    it "returns zero when nothing found" do
      Search.new({who: 'teacher'}, nil).get_count.should == 0
    end

    it "returns number of users" do
      5.times{FactoryGirl.create(:user, teach: true)}
      Search.new({who: 'teacher', no_price_set: true}, nil).get_count.should == 5
    end

    it "doesn't limit count result" do
      (Search::PER_PAGE + 2).times{FactoryGirl.create(:user, teach: true)}
      Search.new({who: 'teacher', no_price_set: true}, nil).get_count.should == Search::PER_PAGE + 2
    end
  end

  describe "#get_result" do
    it "returns result per page" do
      (Search::PER_PAGE + 2).times{FactoryGirl.create(:user, teach: true)}
      Search.new({who: 'teacher', no_price_set: true}, nil).get_result.count.should == Search::PER_PAGE
    end

    it "considers the offset" do
      FactoryGirl.create(:user, teach: true)
      second_user = FactoryGirl.create(:user, teach: true)
      users = Search.new({who: 'teacher', offset: 1, no_price_set: true}, nil).get_result
      users.count.should == 1
      users.first.should == second_user
    end

    context "who condition" do
      before :each do
        FactoryGirl.create(:user, teach: true, learn: false)
        FactoryGirl.create(:user, teach: false, learn: true)
      end

      it "searches for teachers" do
        users = Search.new({who: 'teacher', no_price_set: true}, nil).get_result
        users.count.should == 1
        users.first.teach.should be_true            
      end
      
      it "searches for learners" do
        users = Search.new({who: 'learner', no_price_set: true}, nil).get_result
        users.count.should == 1
        users.first.learn.should be_true            
      end
    end
    
    context "price condition" do
      before :each do
        FactoryGirl.create(:user, learn: true, learner: FactoryGirl.create(:learner, min_price: 0, max_price: 0))
        FactoryGirl.create(:user, learn: true, learner: FactoryGirl.create(:learner, min_price: 1, max_price: 2))
      end

      it "includes people without price" do
        users = Search.new({who: 'learner', no_price_set: true, price: 2}, nil).get_result
        users.count.should == 2
      end

      it "excludes people without price" do
        users = Search.new({who: 'learner', price: 2}, nil).get_result
        users.count.should == 1
        users.first.learner.min_price.should > 0
      end

      it "checks that the price is in the user price range" do
          FactoryGirl.create(:user, learn: true, learner: FactoryGirl.create(:learner, min_price: 3, max_price: 3))
          users = Search.new({who: 'learner', price: 2}, nil).get_result
          users.count.should == 1
          users.first.learner.max_price.should <= 2
          Search.new({who: 'learner', price: 3}, nil).get_result.count.should == 2
      end

    end
    
    context "exclude current user" do
      it "exclude user if it was specified" do
        first_user = FactoryGirl.create(:user, learn: true)
        second_user = FactoryGirl.create(:user, learn: true)
        users = Search.new({who: 'learner', no_price_set: true}, first_user).get_result
        users.count.should == 1
        users.first.should == second_user
      end
    end
    
    context "lang condition" do
      before :each do
        @teacher1 = FactoryGirl.create(:user, teach: true)
        ruby_lang = FactoryGirl.create(:language, name: 'Ruby')
        @teacher1.teacher.languages = [ruby_lang, FactoryGirl.create(:language, name: 'Python')]
        @teacher1.save
        @teacher2 = FactoryGirl.create(:user, teach: true)
        @teacher2.teacher.languages = [FactoryGirl.create(:language, name: 'C++'), ruby_lang]
        @teacher2.save
      end

      it "searches for people who has at least one specified langs" do
        users = Search.new({who: 'teacher', no_price_set: true, langs: 'Ruby,Python'}, nil).get_result
        users.count.should == 2
      end

      it "returns all if langs empty" do
        users = Search.new({who: 'teacher', no_price_set: true, langs: ''}, nil).get_result
        users.count.should == 2
      end

      it "searches by one lang" do
        users = Search.new({who: 'teacher', no_price_set: true, langs: 'C++'}, nil).get_result
        users.count.should == 1
        users.first.should == @teacher2
      end
    end

  end

end