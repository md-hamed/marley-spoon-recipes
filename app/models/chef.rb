# frozen_string_literal: true

class Chef < ContentfulModel::Base
  self.content_type_id = 'chef'

  belongs_to_many :recipes
end

Chef.add_entry_mapping
