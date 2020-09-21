# frozen_string_literal: true

require 'rails_helper'

describe 'recipes GraphQL query' do
  subject(:recipes_query_response) do
    VCR.use_cassette('recipe') do
      MarleySpoonRecipesSchema.execute(
        query,
        variables: nil,
        context: {}
      )
    end
  end

  let(:query) do
    <<-GRAPHQL
    {
      recipe(id: "2E8bc3VcJmA8OgmQsageas") {
        id
        title
        photo
        description
        chef { name }
        tags { name }
      }
    }
    GRAPHQL
  end

  let(:response) { recipes_query_response.dig('data', 'recipe') }

  let(:expected_id) { '2E8bc3VcJmA8OgmQsageas' }
  let(:expected_title) { 'Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing' }
  let(:expected_description) { 'Warmer weather means the ushering in of grill season' }
  let(:expected_chef_name) { 'Mark Zucchiniberg ' }
  let(:expected_photo_url) { '//images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy' }
  let(:expected_tags) { [] }

  it { expect(response.dig('id')).to eq expected_id }
  it { expect(response.dig('title')).to eq expected_title }
  it { expect(response.dig('photo')).to start_with expected_photo_url }
  it { expect(response.dig('description')).to start_with expected_description }
  it { expect(response.dig('chef', 'name')).to eq expected_chef_name }
  it { expect(response.dig('tags')).to eq expected_tags }
end
