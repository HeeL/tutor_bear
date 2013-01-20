require 'spec_helper'

describe UsersController do

  before :each do
    @user = FactoryGirl.create(:user, name: 'Test', uid: '123')
    @learn_langs = ['Ruby', 'PHP']
    @teach_langs = ['Python', 'C++']
    @user.learner.update_attributes(min_price: 1, max_price: 3, languages: create_langs(@learn_langs))
    @user.teacher.update_attributes(min_price: 5, max_price: 7, languages: create_langs(@teach_langs))
    @user.reload
    sign_in @user
  end

  describe '#edit' do
    render_views

    it "shows a filled form" do
      get :edit
      view = response.body
      view.should have_xpath("//input[@name='user[name]' and @value='#{@user.name}']")
      
      view.should have_xpath("//input[@name='user[teacher_attributes][min_price]' and @value='#{@user.teacher.min_price}']")
      view.should have_xpath("//input[@name='user[teacher_attributes][max_price]' and @value='#{@user.teacher.max_price}']")
      view.should have_xpath("//input[@id='teacher_langs' and @value='#{@teach_langs.join(',')}']")
      
      view.should have_xpath("//input[@name='user[learner_attributes][min_price]' and @value='#{@user.learner.min_price}']")
      view.should have_xpath("//input[@name='user[learner_attributes][max_price]' and @value='#{@user.learner.max_price}']")
      view.should have_xpath("//input[@id='learner_langs' and @value='#{@learn_langs.join(',')}']")
    end
  end

  describe '#update' do
    it "rejects bad params" do
      put :update, uid: '12345'
      @user.reload
      @user.uid.should == '123'
    end
  end

  describe '#logout' do
    it "signs out a user" do
      subject.current_user.should_not be_nil
      get :logout
      subject.current_user.should be_nil
    end
  end
  
  describe '#register' do
    it "signs up a user" do
      get :register, email: 'test@test.com', password: 's3cr3Tzz'
      User.where(email: 'test@test.com').count.should == 1
    end

    it "limit registrations from 1 ip" do
      User.destroy_all
      25.times do |n|
        get :register, email: "test#{n}@test.com", password: 's3cr3Tzz'
      end
      User.count.should == 20
      user = User.last
      user.created_at = Time.now - 30.hours
      user.save
      get :register, email: "test25@test.com", password: 's3cr3Tzz'
      User.count.should == 21
    end

  end

  describe '#login' do
    before :each do
      sign_out subject.current_user
      @test_user = FactoryGirl.create(:user)
    end

    it "signs in a user" do
      get :login, email: @test_user.email, password: @test_user.password
      subject.current_user.should == @test_user
    end

    it "checks password and email" do
      get :login, email: @test_user.email, password: "nil_nil"
      subject.current_user.should be_nil
      get :login, email: 'nil_nil@nil_nil.com', password: @test_user.password
      subject.current_user.should be_nil
    end
    
  end

  def create_langs(names)
    names.map{|name| FactoryGirl.create(:language, name: name)}
  end

end