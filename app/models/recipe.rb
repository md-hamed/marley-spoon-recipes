# frozen_string_literal: true

class Recipe < ContentfulModel::Base
  self.content_type_id = 'recipe'

  has_one :chef
  has_many :tags

  def photo_url
    photo.url
  end
end

Recipe.add_entry_mapping
