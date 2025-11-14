# frozen_string_literal: true

module Types
  module Models
    class ArticleType < Types::BaseObject
      description "An article post"

      field :id, ID, null: false
      field :title, String, null: false
      field :body, String
      field :link_fa_icon, String
      field :link_text, String
      field :published, Boolean, null: false do
        def visible?(context)
          !!context[:admin]
        end
      end
      field :created_at, String


      def self.visible?(context)
        super && !!context[:public]
      end
    end
  end
end
