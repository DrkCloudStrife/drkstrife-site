module Visibility
  class PublicProfile < GraphQL::Schema::Visibility::Profile

    def visible_field?(field, ctx)
      !!field.metadata[:public]
    end
  end
end
