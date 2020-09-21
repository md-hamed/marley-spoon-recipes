import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';
import { MockedProvider } from '@apollo/client/testing';
import { buildMultipleRecipes } from '../../../testUtils/helper';
import Recipes from '../../Recipes';
import * as RecipesQuery from '../queries/Recipes.gql';

jest.mock('react-router-dom', () => ({
  ...jest.requireActual('react-router-dom'), // use actual for all non-hook parts
  useParams: () => ({
    page: 1,
  }),
  useRouteMatch: () => ({ url: '/recipes/1' }),
}));

const recipes = buildMultipleRecipes(10);
const mocks = [
  {
    request: {
      query: RecipesQuery,
      variables: {
        page: 1,
        perPage: 2,
      },
    },
    result: {
      data: {
        recipes: {
          nodes: recipes,
          pagesCount: 1,
        },
      },
    },
  },
];

describe('<Recipes />', () => {
  describe('when there is an error', () => {
    const errorMocks = [
      {
        request: {
          query: RecipesQuery,
          variables: {
            page: 1,
            perPage: 2,
          },
        },
        error: new Error('Something went wrong!'),
      },
    ];

    it('renders an error message', async () => {
      const { findByText } = render(
        <MockedProvider mocks={errorMocks} addTypeName={false}>
          <Recipes />
        </MockedProvider>,
      );

      const errorMessage = await findByText('Something went wrong!');
      expect(errorMessage).toBeInTheDocument();
    });
  });

  describe('when it is a loading state', () => {
    it('renders a loader', async () => {
      const { getByText } = render(
        <MockedProvider mocks={mocks} addTypeName={false}>
          <Recipes />
        </MockedProvider>,
      );

      const loading = getByText('Loading');
      expect(loading).toBeInTheDocument();
    });
  });

  it('renders the recipes', async () => {
    const { findByText, getAllByRole } = render(
      <MockedProvider mocks={mocks} addTypeName={false}>
        <Recipes />
      </MockedProvider>,
    );

    const oneOfTheRecipes = await findByText(recipes[0].title);
    const recipePhotos = await getAllByRole('img');

    expect(oneOfTheRecipes).toBeInTheDocument();
    expect(recipePhotos).toHaveLength(recipes.length);
  });
});
