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
                page={page}
                authenticity_token={props.authenticity_token}/>
      );
    });

    return(
        <div>
          <PagesHeader edit_book_url={props.edit_book_url}
                  set_region_url={props.set_region_url}
                  invite_url={props.invite_url}
                  new_page_url={props.new_page_url} />
          <div className="row">
            {rendered_pages}
          </div>
        </div>
    );
  }
});
