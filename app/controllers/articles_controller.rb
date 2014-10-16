class ArticlesController < ApplicationController

  def show
    article = params[:article].gsub('-', '_')
    @current_page = "articles/partials/#{article}"
  end

end
