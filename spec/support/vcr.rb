# frozen_string_literal: true

require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = false
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data '<ACCESS_TOKEN>' do |interaction|
    auths = interaction.request.headers['Authorization'].first
    if (match = auths.match(/^Bearer\s+([^,\s]+)/))
      match.captures.first
    end
  end
end
