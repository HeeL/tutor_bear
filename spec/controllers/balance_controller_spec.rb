require 'spec_helper'

describe BalanceController do

  before :each do
    sign_in FactoryGirl.create(:user)
  end

  describe '#index' do
    context 'show status' do
      it "shows error message" do
        get :index, status: 'fail'
        flash[:error].should be_kind_of(String)
        flash[:notice].should be_nil
      end

      it "shows success message" do
        get :index, status: 'success'
        flash[:notice].should be_kind_of(String)
        flash[:fail].should be_nil
      end
    end
  end

end