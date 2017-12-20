import React from 'react';
import PropTypes from 'prop-types';

import BookHeader from './book_header';
import Page from './page';
import ErrorBoundary from '../../lib/error_boundary';

var createReactClass = require('create-react-class');

const Book = createReactClass({

  propTypes: {
    pages: PropTypes.arrayOf(PropTypes.object),
    set_region_url: PropTypes.string,
    edit_book_url: PropTypes.string,
    new_page_url: PropTypes.string,
    invite_url: PropTypes.string,
    authenticity_token: PropTypes.string
  },

  getInitialState: function () {
    return {pages: this.props.pages, filter_text: ""};
  },

  handleFilterChange: function (e) {
    this.setState({filter_text: e.target.value});
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    var rendered_pages = state.pages.map(function (page) {
      var page_visible = page.name.toLowerCase().indexOf(state.filter_text.toLowerCase()) != -1;
      page_visible = page_visible || page.category.toLowerCase().indexOf(state.filter_text.toLowerCase()) != -1;
      return (
        <ErrorBoundary key={"page_" + page.id}>
          <Page page={page}
                visible={page_visible}
                authenticity_token={props.authenticity_token}/>
        </ErrorBoundary>
      );
    });

    return(
        <div>
          <BookHeader edit_book_url={props.edit_book_url}
                  set_region_url={props.set_region_url}
                  invite_url={props.invite_url}
                  new_page_url={props.new_page_url} />
          <div className="row">
            <div className="col-xs-12">
              <input className="form-control" ref="input_filter"
                     value={state.filter_text} onChange={this.handleFilterChange}
                     disabled={props.disabled} placeholder="Filter" />
            </div>
          </div>
          <div className="row">
            {rendered_pages}
          </div>
        </div>
    );
  }
});

export default Book;
