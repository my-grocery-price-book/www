var ShoppingList = React.createClass({

  propTypes: {
    update_url: React.PropTypes.string,
    delete_url: React.PropTypes.string,
    items_url: React.PropTypes.string,
    item_id: React.PropTypes.number,
    title: React.PropTypes.string,
    item_progress: React.PropTypes.string,
    authenticityToken: React.PropTypes.string
  },

  getInitialState: function () {
    return {title: this.props.title, show_form: true, is_busy: false, is_deleted: false};
  },

  componentDidMount: function() {
    this.setState({show_form: false});
  },

  editTitle: function() {
    this.setState({show_form: true});
  },

  handleTitleChange: function(e) {
    this.setState({title: e.target.value});
  },

  updateTitle: function (submit_event) {
    submit_event.preventDefault();
    this.setState({is_busy: true, show_form: false});
    $.ajax({
      url: this.props.update_url,
      dataType: 'json',
      type: 'PATCH',
      data: {"authenticity_token": this.props.authenticityToken, shopping_list: {title: this.state.title }},
      success: function (response) {
        this.setState({title: response.data.title, is_busy: false});
      }.bind(this),
      error: function (xhr, status, err) {
        this.setState({is_busy: false});
        console.error(status, err.toString());
      }.bind(this)
    });
  },

  handleDeleteSubmit: function(submit_event) {
    submit_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('show');
  },

  handleDelete: function (button_event) {
    button_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('hide');
    this.setState({is_busy: true, show_form: false});
    $.ajax({
      url: this.props.delete_url,
      dataType: 'json',
      type: 'DELETE',
      data: {"authenticity_token": this.props.authenticityToken, shopping_list: {title: this.state.title }},
      success: function (response) {
        console.info(response);
        this.setState({is_deleted: true, is_busy: false});
      }.bind(this),
      error: function (xhr, status, err) {
        this.setState({is_busy: false});
        console.error(status, err.toString());
      }.bind(this)
    });
  },

  render: function () {
    return (
        <div style={this.state.is_deleted ? {display: 'none'} : null }
             className="col-sm-6 col-md-3">
          <ConfirmDelete modal_id={"confirmModal" + this.props.item_id} ok_handler={this.handleDelete}/>
          <div className="thumbnail">
            <div className="caption">
              <form onSubmit={this.updateTitle} action={this.props.update_url} method="post" className="form-inline">
                <input name="_method" value="patch" type="hidden"/>
                <input name="authenticity_token" value={this.props.authenticityToken} type="hidden"/>
                <h3>
                  <input name="shopping_list[title]"
                         className="form-control"
                         value={this.state.title}
                         onChange={this.handleTitleChange}
                         style={this.state.show_form ? null : {display: 'none'}}/>
                  <a href={this.props.items_url}
                     style={this.state.show_form ? {display: 'none'} : null }>
                    {this.state.title}
                  </a>
                </h3>
                <button className="btn btn-primary"
                        role="button"
                        type="submit"
                        style={this.state.show_form ? null : {display: 'none'}}>Update
                </button>
              </form>
              <p>{this.props.item_progress}</p>
              <form onSubmit={this.handleDeleteSubmit} action={this.props.delete_url} method="post" className="form-inline">
                <input name="_method" value="delete" type="hidden"/>
                <input name="authenticity_token" value={this.props.authenticityToken} type="hidden"/>
                <div className="btn-group" role="group">
                  <a href={this.props.items_url}
                     className="btn btn-primary">
                    Items
                  </a>
                  <a style={this.state.show_form ? {display: 'none'} : null}
                     onClick={this.editTitle}
                     className="btn btn-default">
                    Change Title
                  </a>
                  <button style={this.state.show_form ? {display: 'none'} : null}
                          className="btn btn-danger"
                          role="button">
                    Delete
                  </button>
                </div>
              </form>
            </div>
            <div style={this.state.is_busy ? null : {display: 'none'}}
                 className="shopping-list-busy-overlay">
              <span className="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>
            </div>
          </div>
        </div> );
  }
});
