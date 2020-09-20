# frozen_string_literal: true

module Contentful
  class RecipesLoader
    DEFAULT_PAGE_SIZE = 10
    MAX_PAGE_SIZE = 1000

    def initialize(page: nil, per_page: nil)
      @page = normalize_page_argument(page)
      @per_page = normalize_per_page_argument(per_page)
    end

    def nodes
      @nodes ||= Recipe.paginate(page, per_page).load
    end

    def nodes_count
      @nodes_count ||= nodes.total
    end

    def has_next_page
      nodes_count > (page * per_page)
    end

    def has_previous_page
      page > 1
    end

    def pages_count
      (nodes_count / per_page.to_f).ceil
    end

    private

    attr_reader :page, :per_page

    def normalize_page_argument(page)
      return 1 if page.nil? || page < 1

      page
    end

    def normalize_per_page_argument(per_page)
      return DEFAULT_PAGE_SIZE if per_page.nil? || per_page < 1
      return MAX_PAGE_SIZE if per_page > MAX_PAGE_SIZE

      per_page
    end
  end
end
