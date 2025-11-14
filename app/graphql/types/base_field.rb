# frozen_string_literal: true

module Types
  class BaseField < GraphQL::Schema::Field
    argument_class Types::BaseArgument

    def initialize(*args, require_admin: false, **kwargs, &block)
      @require_admin = require_admin
      super(*args, **kwargs, &block)
    end

  end
end
