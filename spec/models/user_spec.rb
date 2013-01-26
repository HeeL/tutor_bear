require 'spec_helper'

describe User do
  subject { User }

  context 'create' do
    it "creates teacher and learner for created user" do
      user = FactoryGirl.create(:user)
      user.learner.should be_kind_of(Learner)
      user.teacher.should be_kind_of(Teacher)
    end

    it "case insensitive to email" do
      user = FactoryGirl.create(:user, email: 'TeSt@gMaIL.com')
      user.email.should eq('test@gmail.com')
    end

  end

  context 'facebook' do
    context "user exists" do
      it "find a user" do
        fb_user = FactoryGirl.create(:user, uid: '123', provider: 'facebook')
        subject.find_fb_user(fb_auth_data).email.should eq(fb_user.email)
      end

      it "should not find a non facebook user" do
        non_fb_user = FactoryGirl.create(:user, uid: '1234', provider: 'facebook')
        fb_user = subject.find_fb_user(fb_auth_data)
        fb_user.should_not eq(non_fb_user)
        fb_user.uid.should eq(fb_auth_data.uid)
      end
    end

    context "user doesn't exist" do
      it "creates a user" do
        subject.last.try(:email).should be_nil
        fb_user = subject.find_fb_user(fb_auth_data)
        subject.last.try(:email).should eq(fb_user.email)
      end
    end

  end

  context 'google' do
    context "user exists" do
      it "find a user" do
        google_user = FactoryGirl.create(:user, email: google_auth_data.info['email'])
        subject.find_google_user(google_auth_data).email.should eq(google_user.email)
      end
    end

    context "user doesn't exist" do
      it "creates a user" do
        subject.last.try(:email).should be_nil
        subject.find_google_user(google_auth_data).email.should eq(subject.last.try(:email))
      end
    end
  end

  def fb_auth_data
    auth = {
      uid: '123',
      provider: 'facebook',
      info: OpenStruct.new({
        email: 'test@test.com'
      }),
      extra: OpenStruct.new({
        raw_info: OpenStruct.new({
          name: 'name'
        })
      })
    }
    OpenStruct.new(auth)
  end

  def google_auth_data
    data = {
      info: {
        'name' => 'Test',
        'email' => 'test@gmail.com'
      }
    }
    OpenStruct.new(data)
  end

end
