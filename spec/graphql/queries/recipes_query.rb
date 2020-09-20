# frozen_string_literal: true

require 'rails_helper'

describe 'recipes GraphQL query' do
  subject(:recipes_query_response) do
    VCR.use_cassette(vcr_query_title) do
      MarleySpoonRecipesSchema.execute(
        query,
        variables: nil,
        context: {}
      )
    end
  end

  let(:response) { recipes_query_response.dig('data', 'recipes') }

  let(:expected_recipe_ids) do
    %w[437eO3ORCME46i02SeCW46 2E8bc3VcJmA8OgmQsageas 5jy9hcMeEgQ4maKGqIOYW6 4dT8tcb6ukGSIg2YyuGEOm]
  end
  let(:expected_chef_names) do
    ['Jony Chives', 'Mark Zucchiniberg ', nil, nil]
  end

  let(:received_recipe_ids) { response.dig('nodes').map { |node| node.dig('id') } }
  let(:received_chef_names) { response.dig('nodes').map { |node| node.dig('chef', 'name') } }

  let(:received_recipes_count) { response.dig('nodesCount') }
  let(:received_previous_page) { response.dig('hasPreviousPage') }
  let(:received_next_page) { response.dig('hasNextPage') }
  let(:received_pages_count) { response.dig('pagesCount') }

  context 'with no pagination parameters' do
    let(:query) do
      <<-GRAPHQL
      {
        recipes {
          nodes {
            id
            title
            photo
            description
            chef { name }
            tags { name }
          }
          nodesCount
          hasPreviousPage
          hasNextPage
          pagesCount
        }
      }
      GRAPHQL
    end
    let(:vcr_query_title) { 'non-paginated-recipes' }

    it { expect(received_recipe_ids).to eq expected_recipe_ids }
    it { expect(received_chef_names).to eq expected_chef_names }
    it { expect(received_recipes_count).to eq 4 }

    it { expect(received_previous_page).to eq false }
    it { expect(received_next_page).to eq false }
    it { expect(received_pages_count).to eq 1 }
  end

  context 'with pagination parameters' do
    let(:query) do
      <<-GRAPHQL
      {
        recipes(page: 1, perPage: 2) {
          nodes {
            id
            title
            photo
            description
            chef { name }
            tags { name }
          }
          nodesCount
          hasPreviousPage
          hasNextPage
          pagesCount
        }
      }
      GRAPHQL
    end
    let(:vcr_query_title) { 'paginated-recipes' }

    it { expect(received_recipe_ids).to eq expected_recipe_ids.first(2) }
    it { expect(received_chef_names).to eq expected_chef_names.first(2) }
    it { expect(received_recipes_count).to eq 4 }

    it { expect(received_previous_page).to eq false }
    it { expect(received_next_page).to eq true }
    it { expect(received_pages_count).to eq 2 }
  end
end
