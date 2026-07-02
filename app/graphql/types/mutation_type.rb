# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :ping, String, null: false, description: "Health check field to keep schema valid"
    field :update_article, mutation: Mutations::ArticleUpdate, description: "Update an article"

    def ping
      "pong"
    end
  end
end
