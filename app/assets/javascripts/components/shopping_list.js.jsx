var ShoppingList = React.createClass({

  propTypes: {
    update_url: React.PropTypes.string,
    delete_url: React.PropTypes.string,
    items_url: React.PropTypes.string,
    item_id: React.PropTypes.number,
    title: React.PropTypes.string,
    item_progress: React.PropTypes.string,
    authenticity_token: React.PropTypes.string
  },

  getInitialState: function () {
    return {show_form: false, is_busy: false, is_deleted: false};
  },

  editTitle: function () {
    this.setState({show_form: true});
  },

  editTitleDone: function () {
    this.setState({show_form: false});
  },

  handleDeleteSubmit: function (submit_event) {
    submit_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('show');
  },

  handleDelete: function (button_event) {
    button_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('hide');
    this.setState({is_busy: true, show_form: false},this.doDelete);
  },

  doDelete: function() {
    $.ajax({
      url: this.props.delete_url,
      dataType: 'json',
      type: 'DELETE',
      data: {"authenticity_token": this.props.authenticity_token}
    }).done(this.deleteSuccesful).fail(this.deleteFailed);
  },

  deleteSuccesful: function () {
    this.setState({is_deleted: true, is_busy: false});
  },

  deleteFailed: function () {
    this.setState({is_busy: false});
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    return (
        <div style={state.is_deleted ? {display: 'none'} : null }
             className="col-sm-6 col-md-4">
          <ConfirmDelete modal_id={"confirmModal" + props.item_id} ok_handler={this.handleDelete}/>
          <div className="thumbnail">
            <div className="caption">
              <ShoppingListTitle update_url={props.update_url}
                                 show_form={state.show_form}
                                 title={props.title}
                                 authenticity_token={props.authenticity_token}
                                 onDone={this.editTitleDone}/>

              <p>{props.item_progress}</p>
              <form onSubmit={this.handleDeleteSubmit} action={props.delete_url} method="post" className="form-inline">
                <input name="_method" value="delete" type="hidden"/>
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <div className="btn-group" role="group" style={state.show_form ? {display: 'none'} : null}>
                  <a href={props.items_url}
                     className="btn btn-primary">
                    Items
                  </a>
                  <a onClick={this.editTitle}
                     className="btn btn-default">
                    Change Title
                  </a>
                  <button className="btn btn-danger"
                          role="button">
                    Delete
                  </button>
                </div>
              </form>
            </div>
            <div style={state.is_busy ? null : {display: 'none'}}
                 className="shopping-list-busy-overlay">
              <span className="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>
            </div>
          </div>
        </div> );
  }
});
