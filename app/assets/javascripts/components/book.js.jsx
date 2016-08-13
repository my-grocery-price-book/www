var Book = React.createClass({

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
      var page_visible = page.name.indexOf(state.filter_text) != -1 || page.category.indexOf(state.filter_text) != -1;
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
              <input className="form-control"
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
