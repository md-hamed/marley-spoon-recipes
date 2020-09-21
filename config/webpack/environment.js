const { environment } = require('@rails/webpacker');

const gqlLoader = {
  test: /\.(graphql|gql)$/,
  exclude: /node_modules/,
  loader: 'graphql-tag/loader',
};

environment.loaders.append('graphql', gqlLoader);

module.exports = environment;
