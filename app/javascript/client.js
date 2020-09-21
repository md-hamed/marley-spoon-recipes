import { ApolloClient, InMemoryCache } from '@apollo/client';

const csrfToken = document
  .querySelector('meta[name=csrf-token]')
  .getAttribute('content');

const client = new ApolloClient({
  uri: '/graphql',
  cache: new InMemoryCache(),
  credentials: 'same-origin',
  headers: {
    'X-CSRF-Token': csrfToken,
  },
});

export default client;
