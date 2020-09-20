# frozen_string_literal: true

module Types
  module Contentful
    class TagType < Types::BaseObject
      field :name, String, null: true
    end
  end
end
