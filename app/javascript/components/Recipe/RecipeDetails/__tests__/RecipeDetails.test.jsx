import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';
import { buildRecipe } from '../../../../testUtils/helper';
import RecipeDetails from '..';

describe('<RecipeDetails />', () => {
  it('renders the recipe', () => {
    const recipe = buildRecipe();
    const { getByRole, getByText } = render(<RecipeDetails loading={false} error={null} recipe={recipe} />);

    const title = getByText(recipe.title);
    const image = getByRole('img');

    expect(title).toBeInTheDocument();
    expect(image).toBeInTheDocument();
  });
});
