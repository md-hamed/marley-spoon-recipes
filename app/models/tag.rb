# frozen_string_literal: true

class Tag < ContentfulModel::Base
  self.content_type_id = 'tag'

  belongs_to_many :recipes
end

Tag.add_entry_mapping
