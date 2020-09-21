import React from 'react';
import { Card, Image } from 'semantic-ui-react';
import RecipeType from '../../types';

const RecipeItem = ({ recipe }) => (
  <Card>
    <Image src={recipe.photo} size="medium" />

    <Card.Content>
      <Card.Header>{recipe.title}</Card.Header>
    </Card.Content>
  </Card>
);

RecipeItem.propTypes = {
  recipe: RecipeType.isRequired,
};

export default RecipeItem;
