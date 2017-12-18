import React from 'react';
import WebpackerReact from 'webpacker-react';

import EntriesForm from './EntriesForm/components/entries_form';
import Book from './PriceBook/components/book';
import ShoppingListItemIndex from './ShoppingList/components/shopping_list_item_index';
import ShoppingListIndex from './ShoppingListsIndex/components/shopping_list_index';

// _railsContext is the Rails context, providing contextual information for rendering
const ShoppingListsIndexApp = (props) => (
  <ShoppingListIndex {...props} />
);


const EntriesFormApp = (props) => (
  <EntriesForm {...props} />
);

const PriceBookApp = (props) => (
  <Book {...props} />
);

const ShoppingListApp = (props) => (
  <ShoppingListItemIndex {...props} />
);

WebpackerReact.setup({EntriesFormApp, PriceBookApp, ShoppingListApp, ShoppingListsIndexApp});