import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { buildRecipe } from '../../../../testUtils/helper';
import RecipeItem from '..';

describe('<RecipeItem />', () => {
  it('renders the title and image of the recipe', () => {
    const recipe = buildRecipe();
    const { getByRole, getByText } = render(
      <MemoryRouter>
        <RecipeItem recipe={recipe} />
      </MemoryRouter>,
    );

    const title = getByText(recipe.title);
    const image = getByRole('img');

    expect(title).toBeInTheDocument();
    expect(image).toBeInTheDocument();
  });
});
