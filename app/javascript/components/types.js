import PropTypes from 'prop-types';

const RecipeType = PropTypes.shape({
  id: PropTypes.string,
  title: PropTypes.string,
  photo: PropTypes.string,
  description: PropTypes.string,
  chef: PropTypes.exact({
    name: PropTypes.string,
  }),
  tags: PropTypes.arrayOf(PropTypes.shape({
    name: PropTypes.string,
  })),
});

export default RecipeType;
