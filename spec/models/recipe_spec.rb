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

  describe '#photo_url' do
    let(:photo_url) do
      '//images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0M'\
      'qseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_'\
      'Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg'
    end

    it { expect(recipe.photo_url).to eq photo_url }
  end
end
