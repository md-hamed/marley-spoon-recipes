Rails.application.routes.draw do
  root 'site#index'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  post '/graphql', to: 'graphql#execute'

  get '/*path' => 'homepage#index'
end
