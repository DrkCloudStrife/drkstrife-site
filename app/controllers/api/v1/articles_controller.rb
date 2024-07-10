module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        articles = Article.list_articles

        # TODO: offset articles based on pagination once implemented
        render json: articles.map(&:decorate)
      end

      def show
        begin
          render json: Article.published.find_by_slug!(params[:id]).decorate
        rescue ActiveRecord::RecordNotFound
          head :not_found
        end
      end

    end
  end
end
