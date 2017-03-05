class ArticlesController < ApplicationController

  def show
    @partial      = params[:article].gsub('-', '_')
    @current_page = "articles/partials/#{@partial}"
  end
end
