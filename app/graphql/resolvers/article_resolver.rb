module Resolvers
  class ArticleResolver < BaseResolver
    type Types::Models::ArticleType, null: false
    argument :id, ID

    def resolve(id:)
      ::Article.published.find(id)
    end

    def self.visible?(context)
      super && !!context[:public]
    end
  end
end
