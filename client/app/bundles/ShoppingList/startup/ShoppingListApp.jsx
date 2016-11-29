import React from 'react';
import ReactOnRails from 'react-on-rails';

import ShoppingListItemIndex from '../components/shopping_list_item_index';

// _railsContext is the Rails context, providing contextual information for rendering
const ShoppingListApp = (props, _railsContext) => (
  <ShoppingListItemIndex {...props} />
);

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ ShoppingListApp });
