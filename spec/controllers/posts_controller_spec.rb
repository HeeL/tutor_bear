require 'spec_helper'

describe PostsController do
  before :each do
    @today_post = FactoryGirl.create(:post)
    @tomorrow_post = FactoryGirl.create(:post, published_at: Date.tomorrow)
  end

  context 'list' do  
    it "shows only published posts in list" do
      get :index
      assigns('posts').should eq([@today_post])
    end
  end

  context 'show' do
    context 'guests' do
      it "shows published posts" do
        get :show, id: @today_post.id
        assigns('post').should eq(@today_post)
      end

      it "doesn't show unpublished posts" do
        get :show, id: @tomorrow_post.id
        assigns('post').should be_nil
      end
    end

    context 'registered users' do
      before :each do
        sign_in FactoryGirl.create(:user)
      end
      it "shows published posts" do
        get :show, id: @today_post.id
        assigns('post').should eq(@today_post)
      end

      it "doesn't show unpublished posts" do
        get :show, id: @tomorrow_post.id
        assigns('post').should be_nil
      end
    end

    context 'admin' do  
      before :each do
        sign_in FactoryGirl.create(:admin_user)
      end

      it "shows unpublished posts" do
        get :show, id: @tomorrow_post
        assigns('post').should eq(@tomorrow_post)
      end

      it "shows published posts" do
        get :show, id: @today_post.id
        assigns('post').should eq(@today_post)
      end
    end
  end

end
