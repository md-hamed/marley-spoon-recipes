import React from 'react';
import { ApolloError } from '@apollo/client';
import PropTypes from 'prop-types';
import {
  Segment,
  Image,
  Header,
  Label,
  Container,
  Dimmer,
  Loader,
  Message,
} from 'semantic-ui-react';
import RecipeType from '../../types';

const RecipeDetails = ({ loading, error, recipe }) => (
  <Container>
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
      <Segment>
        <Image src={recipe.photo} />

        <Header size="medium">{recipe.title}</Header>
        { recipe.chef && <Header size="small">{`From: ${recipe.chef.name}`}</Header> }

        <p>{recipe.description}</p>
        {recipe.tags.map((tag) => (
          <Label key={tag.name} tag>
            {tag.name}
          </Label>
        ))}
      </Segment>
    )}
  </Container>
);

RecipeDetails.propTypes = {
  loading: PropTypes.bool,
  error: PropTypes.objectOf(ApolloError),
  recipe: RecipeType.isRequired,
};

RecipeDetails.defaultProps = {
  loading: true,
  error: null,
};

export default RecipeDetails;
