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
          render file: "#{Articles::ARTICLE_DATA_PATH}#{article_file}.json", content_type: "application/json", layout: false, cached: true
        rescue
          head :not_found
        end
      end

    private

      def article_file
        params.require(:id)
      end

    end
  end
end
