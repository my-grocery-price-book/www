import React from 'react';
import WebpackerReact from 'webpacker-react';

import ShoppingListIndex from '../components/shopping_list_index';

// _railsContext is the Rails context, providing contextual information for rendering
const ShoppingListsIndexApp = (props) => (
  <ShoppingListIndex {...props} />
);

var elements = document.querySelectorAll('[data-react-class="ShoppingListsIndexApp"]');

if(elements.length > 0) {
  WebpackerReact.setup({ShoppingListsIndexApp});
}