class LanguagesController < ApplicationController
  
  respond_to :json

  def match_names
    @langs = Language.match_names(params[:name], params[:exact])
    respond_with(@langs)
  end
  
end
