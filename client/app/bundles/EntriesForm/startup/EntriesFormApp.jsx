import React from 'react';
import ReactOnRails from 'react-on-rails';

import EntriesForm from '../components/entries_form';

// _railsContext is the Rails context, providing contextual information for rendering
const EntriesFormApp = (props, _railsContext) => (
  <EntriesForm {...props} />
);

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ EntriesFormApp });
