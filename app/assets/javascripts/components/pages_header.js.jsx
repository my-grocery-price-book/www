function PagesHeader(props) {
  return(
      <div className="row pages-header">
        <div className="col-md-12">
          <h1>Price Book</h1>
          <div className="btn-group" role="group">
            <a href={props.edit_book_url} className="btn btn-default btn-sm">Edit Book</a>
            <a href={props.set_region_url} className="btn btn-default btn-sm">Region</a>
            <a href={props.invite_url} className="btn btn-default btn-sm">Invite Shopper</a>
            <a href={props.new_page_url} className="btn btn-default btn-sm">New Page</a>
          </div>
        </div>
      </div>
  );
}

PagesHeader.propTypes = {
  set_region_url: React.PropTypes.string,
  edit_book_url: React.PropTypes.string,
  new_page_url: React.PropTypes.string,
  invite_url: React.PropTypes.string
};