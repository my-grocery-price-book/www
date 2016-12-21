import React from 'react';
import ReactOnRails from 'react-on-rails';

import ShoppingListIndex from '../components/shopping_list_index';

// _railsContext is the Rails context, providing contextual information for rendering
const ShoppingListsIndexApp = (props, _railsContext) => (
  <ShoppingListIndex {...props} />
);

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ ShoppingListsIndexApp });
