import React from 'react';
import WebpackerReact from 'webpacker-react';

import ShoppingListItemIndex from '../components/shopping_list_item_index';

// _railsContext is the Rails context, providing contextual information for rendering
const ShoppingListApp = (props) => (
  <ShoppingListItemIndex {...props} />
);

var elements = document.querySelectorAll('[data-react-class="ShoppingListApp"]');

if(elements.length > 0) {
  WebpackerReact.setup({ShoppingListApp});
}
