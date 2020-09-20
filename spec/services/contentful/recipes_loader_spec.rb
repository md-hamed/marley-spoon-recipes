# typed: false
require 'rails_helper'

RSpec.describe Contentful::RecipesLoader do
  let(:recipes) do
    [
      double(title: Faker::Food.dish),
      double(title: Faker::Food.dish),
      double(title: Faker::Food.dish),
      double(title: Faker::Food.dish),
      double(title: Faker::Food.dish)
    ]
  end
  let(:total_result_count) { 5 }

  before do
    entities_stub = double(total: total_result_count, to_a: recipes)
    contentful_array = double(load: entities_stub)
    allow(Recipe).to receive(:paginate).and_return contentful_array
  end

  context 'with no pagination parameters' do
    subject(:recipes_loader) { described_class.new }

    it { expect(recipes_loader.nodes.to_a).to eq recipes }
    it { expect(recipes_loader.nodes_count).to eq recipes.count }
    it { expect(recipes_loader.has_next_page).to eq false }
    it { expect(recipes_loader.has_previous_page).to eq false }
    it { expect(recipes_loader.pages_count).to eq 1 }
  end

  context 'with pagination parameters' do
    subject(:recipes_loader) { described_class.new(page: page, per_page: per_page) }

    describe 'when there is no result' do
      let(:recipes) { [] }
      let(:total_result_count) { 0 }

      let(:page) { 1 }
      let(:per_page) { 10 }

      it { expect(recipes_loader.nodes.to_a).to eq recipes }
      it { expect(recipes_loader.nodes_count).to be_zero }
      it { expect(recipes_loader.has_next_page).to eq false }
      it { expect(recipes_loader.has_previous_page).to eq false }
      it { expect(recipes_loader.pages_count).to be_zero }
    end

    describe 'when result has one page' do
      let(:recipes) do
        [
          double(title: Faker::Food.dish),
          double(title: Faker::Food.dish)
        ]
      end
      let(:total_result_count) { 2 }

      let(:page) { 1 }
      let(:per_page) { 2 }

      it { expect(recipes_loader.nodes.to_a).to eq recipes }
      it { expect(recipes_loader.nodes_count).to eq recipes.count }
      it { expect(recipes_loader.has_next_page).to eq false }
      it { expect(recipes_loader.has_previous_page).to eq false }
      it { expect(recipes_loader.pages_count).to eq 1 }
    end

    describe 'when result has multiple pages' do
      let(:recipes) do
        [
          double(title: Faker::Food.dish),
          double(title: Faker::Food.dish)
        ]
      end
      let(:total_result_count) { 6 }
      let(:page) { 1 }
      let(:per_page) { 2 }

      it { expect(recipes_loader.nodes.to_a).to eq recipes }
      it { expect(recipes_loader.nodes_count).to eq 6 }
      it { expect(recipes_loader.pages_count).to eq 3 }

      context 'and we are in the first page' do
        it { expect(recipes_loader.has_next_page).to eq true }
        it { expect(recipes_loader.has_previous_page).to eq false }
      end

      context 'and we are in the middle page' do
        let(:page) { 2 }

        it { expect(recipes_loader.has_next_page).to eq true }
        it { expect(recipes_loader.has_previous_page).to eq true }
      end

      context 'and we are in the last page' do
        let(:page) { 3 }

        it { expect(recipes_loader.has_next_page).to eq false }
        it { expect(recipes_loader.has_previous_page).to eq true }
      end
    end
  end

  context 'with invalid page parameters' do
    subject(:recipes_loader) { described_class.new(page: page) }

    describe 'when page is not provided' do
      let(:page) { nil }

      it 'sets it by default to 1' do
        expect(recipes_loader.has_next_page).to eq false
        expect(recipes_loader.has_previous_page).to eq false
      end
    end

    describe 'when page has a negative value' do
      let(:page) { -1 }

      it 'sets page is negative' do
        expect(recipes_loader.has_next_page).to eq false
        expect(recipes_loader.has_previous_page).to eq false
      end
    end
  end

  context 'with invalid per_page parameters' do
    subject(:recipes_loader) { described_class.new(per_page: per_page) }

    let(:total_result_count) { described_class::DEFAULT_PAGE_SIZE + 1 }

    describe 'when per_page is not provided' do
      let(:per_page) { nil }

      it 'sets it to a default value' do
        expect(recipes_loader.pages_count).to eq 2
      end
    end

    describe 'when per_page is negative' do
      let(:per_page) { nil }

      it 'sets it to a default value' do
        expect(recipes_loader.pages_count).to eq 2
      end
    end

    describe 'when per_page is bigger than the maximum page' do
      let(:per_page) { described_class::MAX_PAGE_SIZE + 1 }
      let(:total_result_count) { described_class::MAX_PAGE_SIZE + 1 }

      it 'sets it to the max page' do
        expect(recipes_loader.pages_count).to eq 2
      end
    end
  end
end
