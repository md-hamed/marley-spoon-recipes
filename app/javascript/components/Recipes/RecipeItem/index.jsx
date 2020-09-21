import React from 'react';
import { generatePath, Link } from 'react-router-dom';
import { Card, Image } from 'semantic-ui-react';
import RecipeType from '../../types';

const RecipeItem = ({ recipe }) => {
  const href = generatePath('/recipe/:id', { id: recipe.id });

  return (
    <Card link as={Link} to={href}>
      <Image src={recipe.photo} size="medium" />

      <Card.Content>
        <Card.Header>{recipe.title}</Card.Header>
      </Card.Content>
    </Card>
  );
};

RecipeItem.propTypes = {
  recipe: RecipeType.isRequired,
};

export default RecipeItem;
