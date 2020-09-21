import React from 'react';
import PropTypes from 'prop-types';
import { ApolloError } from '@apollo/client';
import {
  Container,
  Card,
  Header,
  Dimmer,
  Loader,
  Message,
  Pagination,
  Divider,
} from 'semantic-ui-react';
import RecipeItem from '../RecipeItem';
import RecipeType from '../../types';

const RecipeList = ({
  error,
  loading,
  recipes,
  pagesCount,
  handlePageChange,
  activePage,
}) => (
  <Container>
    <Header as="h1">Marley Spoon Recipes!</Header>

    {error && (
      <Message negative>
        <Message.Header>Something went wrong!</Message.Header>
        <p>Please try again later.</p>
      </Message>
    )}

    {loading ? (
      <Dimmer active>
        <Loader>Loading</Loader>
      </Dimmer>
    ) : (
      <Card.Group divided="true">
        {recipes.map((recipe) => (
          <RecipeItem key={recipe.id} recipe={recipe} />
        ))}
      </Card.Group>
    )}

    <Divider horizontal />

    <Pagination
      activePage={activePage}
      totalPages={pagesCount}
      onPageChange={handlePageChange}
    />
  </Container>
);

RecipeList.propTypes = {
  error: PropTypes.objectOf(ApolloError),
  loading: PropTypes.bool,
  recipes: PropTypes.arrayOf(RecipeType),
  pagesCount: PropTypes.number,
  handlePageChange: PropTypes.func.isRequired,
  activePage: PropTypes.number,
};

RecipeList.defaultProps = {
  error: null,
  loading: true,
  recipes: [],
  pagesCount: 0,
  activePage: 1,
};

export default RecipeList;
