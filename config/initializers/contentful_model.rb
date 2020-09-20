ContentfulModel.configure do |config|
  config.access_token = Rails.application.credentials.config.dig(:contentful, :access_token)
  config.space = Rails.application.credentials.config.dig(:contentful, :space)
end
