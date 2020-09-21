// TODO: This file should be execluded from the build
import { build, fake } from 'test-data-bot';

export const buildRecipe = build('recipe').fields({
  id: fake((f) => f.random.uuid()),
  title: fake((f) => f.lorem.sentence()),
  description: fake((f) => f.lorem.sentences()),
  photo: fake((f) => f.image.imageUrl()),
  chef: {
    name: fake((f) => f.name.firstName()),
  },
  tags: [
    { name: fake((f) => f.lorem.word()) },
    { name: fake((f) => f.lorem.word()) },
  ],
});

export const buildMultipleRecipes = (amount) => Array.from({ length: amount }, () => buildRecipe());
