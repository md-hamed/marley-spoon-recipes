# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :recipes, Types::Contentful::RecipePageType, null: true do
      argument :page, Integer, required: false
      argument :per_page, Integer, required: false
    end

    field :recipe, Types::Contentful::RecipeType, null: true do
      argument :id, String, required: true
    end

    def recipes(page: nil, per_page: nil)
      ::Contentful::RecipesLoader.new(page: page, per_page: per_page)
    end

    def recipe(id:)
      Recipe.find(id)
    end
  end
end
