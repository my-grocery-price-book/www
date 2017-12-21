import React from 'react';
import PropTypes from 'prop-types';

function BookHeader(props) {
  return(
      <div className="row pages-header pages-options">
        <div className="col-md-12">
          <h1>Price Book</h1>
          <div className="btn-group" role="group">
            <a href={props.new_page_url} title="Add New Page" className="btn btn-default btn-sm">Add</a>
            <a href={props.edit_book_url} title="Edit Book" className="btn btn-default btn-sm">Edit</a>
            <a href={props.set_region_url} title="Set Region" className="btn btn-default btn-sm">Region</a>
            <a href={props.invite_url} title="Invite User to this Book" className="btn btn-default btn-sm">Invite</a>
            <a href={props.new_book_store_url} title="New Store" className="btn btn-default btn-sm">New Store</a>
          </div>
        </div>
      </div>
  );
}

BookHeader.propTypes = {
  set_region_url: PropTypes.string,
  edit_book_url: PropTypes.string,
  new_page_url: PropTypes.string,
  invite_url: PropTypes.string
};

export default BookHeader;