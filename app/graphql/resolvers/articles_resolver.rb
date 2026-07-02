module Resolvers
  class ArticlesResolver < BaseResolver
    type [Types::Models::ArticleType], null: false
    argument :ids, [ID], required: false, description: 'Filter by a single ID or an array of IDs'

    def resolve(ids: nil)
      if ids.present?
        scope.where(id: ids)
      else
        scope
      end
    end

    private

    def scope
      !!context[:public] ? ::Article.published : ::Article.all
    end
  end
end
