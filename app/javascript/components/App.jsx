import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect,
} from 'react-router-dom';
import Recipes from './Recipes';
import Recipe from './Recipe';

const App = () => (
  <Router>
    <Switch>
      <Route exact path="/">
        <Redirect to="/recipes" />
      </Route>
      <Route exact path="/recipes" component={Recipes} />
      <Route
        exact
        path="/recipe"
        component={Recipe}
      />
    </Switch>
  </Router>
);

export default App;
