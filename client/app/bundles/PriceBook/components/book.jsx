import React, { PropTypes } from 'react';

import BookHeader from './book_header';
import Page from './page';

const Book = React.createClass({

  propTypes: {
    pages: React.PropTypes.arrayOf(React.PropTypes.object),
    set_region_url: React.PropTypes.string,
    edit_book_url: React.PropTypes.string,
    new_page_url: React.PropTypes.string,
    invite_url: React.PropTypes.string,
    authenticity_token: React.PropTypes.string
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
          <Page key={"page_" + page.id}
                page={page}
                visible={page_visible}
                authenticity_token={props.authenticity_token}/>
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
