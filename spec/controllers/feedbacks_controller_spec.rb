require 'spec_helper'

describe FeedbacksController do

  it "sends feedback from registered user" do
    user = FactoryGirl.create(:user)
    sign_in user
    text = "Tasty test text from registered"
    post :send_feedback, text: text
    mail = ActionMailer::Base.deliveries.last
    mail.body.should include(user.email, text)
  end

  it "send feedback from not registered user" do
    from = "test@test.com"
    text = "Tasty test text"
    post :send_feedback, from: from, text: text
    mail = ActionMailer::Base.deliveries.last
    mail.subject.should == "[TutorBear] Feedback from a user"
    mail.body.should include(from, text)
  end

end