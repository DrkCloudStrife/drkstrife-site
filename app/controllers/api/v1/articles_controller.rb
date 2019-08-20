module Api
  module V1
    class ArticlesController < ApplicationController

      ARTICLE_DATA_PATH = "articles/data/"

      def index
        path = Rails.root.join('app/views').join(ARTICLE_DATA_PATH).join("*.json")

        articles = Dir.glob(path).inject([]) do |memo, article|
          memo << JSON.parse(Pathname.new(article).read)
          memo
        end

        # TODO: offset articles based on pagination once implemented

        render json: articles
      end

      def show
        begin
          render file: "#{ARTICLE_DATA_PATH}#{article_file}.json", content_type: "application/json", layout: false
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
