# frozen_string_literal: true

require 'rails_helper'

describe Types::Contentful::RecipeType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type(String) }
  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to have_field(:photo).of_type(String) }
  it { is_expected.to have_field(:description).of_type(String) }
  it { is_expected.to have_field(:chef).of_type(Types::Contentful::ChefType) }
  it { is_expected.to have_field(:tags).of_type('[Tag!]') }
end
