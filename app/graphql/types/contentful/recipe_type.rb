# frozen_string_literal: true

module Types
  module Contentful
    class RecipeType < Types::BaseObject
      field :id, String, null: true
      field :title, String, null: true
      field :photo, String, null: true, method: :photo_url
      field :description, String, null: true
      field :chef, Types::Contentful::ChefType, null: true
      field :tags, [Types::Contentful::TagType], null: true
    end
  end
end
