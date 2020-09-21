import React from 'react';
import { useQuery } from '@apollo/client';
import { useParams } from 'react-router-dom';
import RecipeQuery from './queries/Recipe.gql';
import RecipeDetails from './RecipeDetails';

const Recipe = () => {
  const { id } = useParams();

  const { loading, error, data } = useQuery(RecipeQuery, {
    variables: { id },
  });

  if (loading || error) {
    return (
      <RecipeDetails
        loading={loading}
        error={error}
      />
    );
  }

  return <RecipeDetails loading={loading} error={error} recipe={data.recipe} />;
};

export default Recipe;
