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
} from 'semantic-ui-react';
import RecipeItem from '../RecipeItem';
import RecipeType from '../../types';

const RecipeList = ({
  error,
  loading,
  recipes,
  pagesCount,
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
  </Container>
);

RecipeList.propTypes = {
  error: ApolloError,
  loading: PropTypes.bool,
  recipes: PropTypes.arrayOf(RecipeType),
  pagesCount: PropTypes.number,
};

RecipeList.defaultProps = {
  error: false,
  loading: true,
  recipes: [],
  pagesCount: 0,
};

export default RecipeList;
