# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chef, type: :model do
  let!(:chef) do
    VCR.use_cassette('chef') do
      described_class.first
    end
  end

  subject do
    VCR.use_cassette('chef-recipes') do
      chef.recipes
    end
  end

  it 'belongs to many recipes' do
    is_expected.to all(be_a Recipe)
  end
end
