require 'spec_helper'

describe ContactsController do

  before :each do
    @current_user = FactoryGirl.create(:user)
    @receiver = FactoryGirl.create(:user)
    sign_in @current_user
  end

  it "checks for signed in user" do
    sign_out @current_user
    post :send_contacts, receive_as: 'teacher', send_to: @receiver.id, locale: 'en'
    ContactLog.count.should == 0
  end

  it "doesn't allow to contact the same person too often" do
    post :send_contacts, receive_as: 'teacher', send_to: @receiver.id, locale: 'en'
    ContactLog.count.should == 1
    post :send_contacts, receive_as: 'teacher', send_to: @receiver.id, locale: 'en'
    ContactLog.count.should == 1
    last_contact = ContactLog.last
    last_contact.created_at = 8.days.ago
    last_contact.save
    post :send_contacts, receive_as: 'teacher', send_to: @receiver.id, locale: 'en'
    ContactLog.count.should == 2      
  end

  context "teacher" do
    it "logs a contact for teacher" do
      post :send_contacts, receive_as: 'teacher', send_to: @receiver.id, locale: 'en'
      contact_log = ContactLog.last
      contact_log.user_received.should == @receiver.id
      contact_log.user_sent.should == @current_user.id
      contact_log.received_as.should == 'teacher'
    end
    
    it "sends an email to a teacher" do
      post :send_contacts, receive_as: 'teacher', send_to: @receiver.id, locale: 'en'
      mail = ActionMailer::Base.deliveries.last
      mail.subject.should == "[TutorBear] Teacher sent you his contact details"
      mail.to.first.should == @receiver.email
      mail.body.should include(@current_user.email)
    end
  end  

  context 'learner' do
    it "logs a contact" do
      post :send_contacts, receive_as: 'learner', send_to: @receiver.id, locale: 'en'
      contact_log = ContactLog.last
      contact_log.user_received.should == @receiver.id
      contact_log.user_sent.should == @current_user.id
      contact_log.received_as.should == 'learner'
    end

    it "sends an email to a teacher" do
      post :send_contacts, receive_as: 'learner', send_to: @receiver.id, locale: 'en'
      mail = ActionMailer::Base.deliveries.last
      mail.subject.should == "[TutorBear] Learner sent you his contact details"
      mail.to.first.should == @receiver.email
      mail.body.should include(@current_user.email)
    end
  end

  it "checks that receiver param is valid" do
    expect { post :send_contacts, receive_as: 'invalid', send_to: @receiver.id, locale: 'en' }.to raise_error(RuntimeError)
  end

end