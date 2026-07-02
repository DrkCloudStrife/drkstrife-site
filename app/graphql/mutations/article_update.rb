# frozen_string_literal: true

module Mutations
  class ArticleUpdate < BaseMutation
    field :article, Types::Models::ArticleType, null: true
    field :errors, [String], null: false

    argument :id, ID, required: true
    argument :title, String, required: true
    argument :body, String
    argument :link_fa_icon, String
    argument :link_text, String
    argument :published, Boolean, required: true

    def resolve(id:, **attributes)
      return { article: nil, errors: ['Unauthorized Access'] } unless context[:is_admin]

      article = Article.find_by(id: id)
      return { article: nil, errors: ['Article not found'] } if article.nil?

      if article.update(attributes)
        { article: article, errors: [] }
      else
        { article: nil, errors: article.errors.full_messages }
      end
    end

    def self.visible?(context)
      super && !!context[:admin]
    end
  end
end
