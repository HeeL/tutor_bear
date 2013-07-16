require 'spec_helper'

describe PostsController do
  before :each do
    @past_post = FactoryGirl.create(:post)
    @tomorrow_post = FactoryGirl.create(:post, published_at: Date.tomorrow)
  end

  context 'list' do  
    it "shows only published posts in list" do
      get :index
      assigns('posts').count.should eq(1)
      assigns('posts').first.id.should eq(@past_post.id)
    end
  end

  describe "#add_cmt" do
    before :each do
      @post = FactoryGirl.create(:post)
    end

    it "adds new comment" do
      post :add_cmt, post_id: @post.id, name: 'test_name', text: 'test_text'
      cmt = Comment.last
      cmt.name.should eq('test_name')
      cmt.text.should eq('test_text')
    end

    it "adds nested comment" do
      parent_cmt = FactoryGirl.create(:comment, commentable: @post)
      post :add_cmt, post_id: @post.id, cmt_id: parent_cmt.id, name: 'test_name', text: 'test_text'
      cmt = Comment.last
      cmt.parent_id.should eq(parent_cmt.id)
    end
  end

  context 'show' do
    context 'guests' do
      it "shows published posts" do
        get :show, id: @past_post.id
        assigns('post').should eq(@past_post)
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
        get :show, id: @past_post.id
        assigns('post').should eq(@past_post)
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
        get :show, id: @past_post.id
        assigns('post').should eq(@past_post)
      end
    end
  end

end
