# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) do
    VCR.use_cassette('recipes') do
      described_class.all.load.last
    end
  end

  it 'has one chef' do
    expect(recipe.chef).to be_a Chef
  end

  it 'has many tags' do
    expect(recipe.tags).to all(be_a Tag)
  end
end
