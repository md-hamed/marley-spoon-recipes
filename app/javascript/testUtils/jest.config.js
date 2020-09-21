module.exports = {
  bail: true,
  rootDir: '.',
  roots: ['<rootDir>/../'],
  testMatch: ['/**/__tests__/**/*.{js,jsx}'],
  testEnvironment: 'jsdom',
  transformIgnorePatterns: [
    '[/\\\\]node_modules[/\\\\].+\\.(js|jsx|js|jsx|json)$',
  ],
  transform: {
    '\\.(gql|graphql)$': 'jest-transform-graphql',
    '.*': 'babel-jest',
  },
};
