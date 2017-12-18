import React from 'react';
import WebpackerReact from 'webpacker-react';

import Book from '../components/book';

// _railsContext is the Rails context, providing contextual information for rendering
const PriceBookApp = (props) => (
  <Book {...props} />
);

var elements = document.querySelectorAll('[data-react-class="PriceBookApp"]');

if(elements.length > 0) {
  WebpackerReact.setup({PriceBookApp});
}