# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:tag) do
    VCR.use_cassette('tag') do
      described_class.first
    end
  end

  subject do
    VCR.use_cassette('tag-recipes') do
      tag.recipes
    end
  end

  it 'belongs to many recipes' do
    is_expected.to all(be_a Recipe)
  end
end
