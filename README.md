# Marley Spoon Recipes Guide!

## Introduction
This is a project to demonstrate the usage of Marley Spoon recipes on [Contentful](https://contentful.com/). It consumes the data from the [Contentful Delivery API](https://www.contentful.com/developers/docs/references/content-delivery-api) and displays it. It uses Ruby on Rails in the backend to expose a GraphQL API that is consumed by a React application.



## User stories
- As a Marley Spoon Recipes Guide user, I want to see a *paginated* list of recipes available in the system. Every recipe should display its title and image.
- As a Marley Spoon Recipes Guide user, I want to see more details about any recipe in the list when I select it. A recipe should display its title, image, list of tags, description, and chef name.

![Preview](https://i.ibb.co/Z6MfBg3/preview.gif)

## Versions
- `Ruby 2.6.2`
- `Rails 6.0.3`
- `Node 10.16.3`
- `React 16.13.1`

## How to run it?
It's pretty straightforward.
- You will need to have bundler installed by running

`$ gem install bundler:1.17.2`
- I personally use `rvm` and the project already have the config required to configure the ruby version and the gemset.
- Install the depedencies using `bundler` by running:

`$ bundle`
- Install JS depedencies using `yarn` by running:

`$ yarn install`
- Run the rails server by running `rs`.
and voila! The project should be running @ `http://localhost:3000/` 🎉
- To access `graphiql`, go to `http://localhost:3000/graphiql`.

## How to run the specs?
### Run Rails specs
To run the specs; it's pretty straightforward too, just run

`$ rspec`

### Run JS specs
To run the specs; it's pretty straightforward too, just run

`$ yarn test`

## Discussion
- For consuming Contentful APIs, I used [contentful_model](https://github.com/contentful/contentful_model) which served me really well as it's a thin wrapper around the [Contentful Delivery API](https://www.contentful.com/developers/docs/references/content-delivery-api).
- Contentful API implements recipes pagination in a limit-offset scheme which is not ideal and it has all the downsides of limit-offset based pagination. This project is just proxying this scheme.
- I made sure to load all the recipe data in the recipes index page, even though we just need the `title` and `description`. The reasoning behind that is that I configured Apollo cache so that when a user clicks on the recipe, she is going to get the recipe from apollo cache directly without needing to hit the network. If the user loads the recipe page directly without going through the index page, it's going to be loaded from the network normally.
- Future work: Do a better handling for the back button behavior. Do a more robust error handling.
