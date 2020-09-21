import React from 'react';
import 'semantic-ui-css/semantic.min.css';
import { ApolloProvider } from '@apollo/client';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect,
} from 'react-router-dom';
import client from '../client';
import Recipes from './Recipes';
import Recipe from './Recipe';

const App = () => (
  <ApolloProvider client={client}>
    <Router>
      <Switch>
        <Route exact path="/">
          <Redirect to="/recipes/1" />
        </Route>
        <Route exact path="/recipes/:page?" component={Recipes} />
        <Route exact path="/recipe/:id" component={Recipe} />
      </Switch>
    </Router>
  </ApolloProvider>
);

export default App;
