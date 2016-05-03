var PagesIndex = React.createClass({

  propTypes: {
    pages: React.PropTypes.arrayOf(React.PropTypes.object),
    set_region_url: React.PropTypes.string,
    edit_book_url: React.PropTypes.string,
    new_page_url: React.PropTypes.string,
    invite_url: React.PropTypes.string,
    authenticity_token: React.PropTypes.string
  },

  getInitialState: function () {
    return {pages: this.props.pages};
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    var rendered_pages = state.pages.map(function (page) {
      return (
          <Page key={"page_" + page.id}
                show_url={page.show_url}
                edit_url={page.edit_url}
                delete_url={page.delete_url}
                page_id={page.id}
                name={page.name}
                category={page.category}
                unit={page.unit}
                authenticity_token={props.authenticity_token}/>
      );
    });

    return <div>
      <div className="row">
        <div className="col-md-12">
          <h1>Price Book</h1>
          <a href={props.edit_book_url} className="btn btn-default btn-sm">Edit Book</a>
          <a href={props.set_region_url} className="btn btn-default btn-sm">Set Region</a>
          <a href={props.invite_url} className="btn btn-default btn-sm">Invite Shopper</a>
          <a href={props.new_page_url} className="btn btn-primary btn-sm">New Page</a>
        </div>
      </div>
      <div className="row">
        {rendered_pages}
      </div>
    </div>;
  }
});
