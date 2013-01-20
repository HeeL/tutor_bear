class SearchController < ApplicationController

  before_filter :search

  def index
    @users = @search.get_result
    render layout: false
  end

  def get_count
    render text: @search.get_count
  end

  private
  
  def search
    @search = Search.new(params, current_user)
  end

end
