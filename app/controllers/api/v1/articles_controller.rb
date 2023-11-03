module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        @articles = Articles.list_articles

        # TODO: offset articles based on pagination once implemented
        render json: @articles
      end

      def show
        begin
          render json: Articles.published.find_by_slug!(params[:id])
        rescue ActiveRecord::RecordNotFound
          head :not_found
        end
      end

    end
  end
end
