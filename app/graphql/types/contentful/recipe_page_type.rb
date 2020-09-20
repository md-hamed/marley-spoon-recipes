# frozen_string_literal: true

module Types
  module Contentful
    class RecipePageType < Types::BaseObject
      field :nodes, [Types::Contentful::RecipeType], null: false
      field :nodes_count, Integer, null: false
      field :has_previous_page, Boolean, null: false
      field :has_next_page, Boolean, null: false
      field :pages_count, Integer, null: false
    end
  end
end
