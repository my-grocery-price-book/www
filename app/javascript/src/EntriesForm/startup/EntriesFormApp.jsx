import React from 'react';
import WebpackerReact from 'webpacker-react';

import EntriesForm from '../components/entries_form';
import Book from '../components/book';

// _railsContext is the Rails context, providing contextual information for rendering
const EntriesFormApp = (props) => (
  <EntriesForm {...props} />
);

// _railsContext is the Rails context, providing contextual information for rendering
const PriceBookApp = (props) => (
  <Book {...props} />
);

WebpackerReact.setup({EntriesFormApp, PriceBookApp});