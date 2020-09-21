import { ApolloClient, InMemoryCache } from '@apollo/client';

const csrfToken = document
  .querySelector('meta[name=csrf-token]')
  .getAttribute('content');

const cache = new InMemoryCache({
  typePolicies: {
    Query: {
      fields: {
        recipe(_, { args, toReference }) {
          return toReference({
            __typename: 'Recipe',
            id: args.id,
          });
        },
      },
    },
  },
});

const client = new ApolloClient({
  uri: '/graphql',
  cache,
  credentials: 'same-origin',
  headers: {
    'X-CSRF-Token': csrfToken,
  },
});

export default client;
