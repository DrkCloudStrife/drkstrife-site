# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def self.visible?(context)
      super && !!context[:public]
    end
  end
end
