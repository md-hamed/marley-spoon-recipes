import React from 'react';
import { useQuery } from '@apollo/client';
import RecipeList from './RecipeList';
import RecipesQuery from './queries/Recipes.gql';

const Recipes = () => {
  const { loading, error, data } = useQuery(RecipesQuery);

  if (loading || error) return <RecipeList loading={loading} error={error} />;

  return (
    <RecipeList
      loading={loading}
      error={error}
      recipes={data.recipes.nodes}
      nodesCount={data.nodesCount}
      hasPreviousPage={data.hasPreviousPage}
      hasNextPage={data.hasNextPage}
      pagesCount={data.pagesCount}
    />
  );
};

export default Recipes;
