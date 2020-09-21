import React from 'react';
import { useQuery } from '@apollo/client';
import { useParams, useHistory } from 'react-router-dom';
import RecipeList from './RecipeList';
import RecipesQuery from './queries/Recipes.gql';

const Recipes = () => {
  const PER_PAGE = 2;
  const { page } = useParams();
  const activePage = Number(page) || 1;

  const history = useHistory();
  const handlePaginationChange = (e, data) => history.push(`/recipes/${data.activePage}`);

  const { loading, error, data } = useQuery(RecipesQuery, {
    variables: { page: activePage, perPage: PER_PAGE },
  });

  if (loading || error) {
    return (
      <RecipeList
        loading={loading}
        error={error}
        handlePageChange={handlePaginationChange}
      />
    );
  }

  return (
    <RecipeList
      loading={loading}
      error={error}
      recipes={data.recipes.nodes}
      pagesCount={data.recipes.pagesCount}
      handlePageChange={handlePaginationChange}
    />
  );
};

export default Recipes;
