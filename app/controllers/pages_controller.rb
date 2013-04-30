require 'open-uri'

class PagesController < ApplicationController
  
  def index
  end

  def redirect
    redirect_to Rack::Utils.unescape(revert_url(params[:path])), status: 301
  end

  def image
    url = "http://i.imgur.com/#{params[:name]}.#{params[:format]}"
    render text: open(url).read
  end
  
end
