import React from 'react';
import ReactOnRails from 'react-on-rails';

import Book from '../components/book';

// _railsContext is the Rails context, providing contextual information for rendering
const PriceBookApp = (props, _railsContext) => (
  <Book {...props} />
);

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ PriceBookApp });
