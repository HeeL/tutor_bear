require 'spec_helper'

describe Comment do

  context "create" do
    before :each do
      @post = FactoryGirl.create(:post)
      FactoryGirl.create(:comment, commentable: @post)
    end

    it "sends email notification" do
      mail = ActionMailer::Base.deliveries.last
      mail.subject.should == "[TutorBear] New comment to an Article"
      mail.body.should include("/posts/#{@post.id}")
    end
  end

end