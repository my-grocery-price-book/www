var ShoppingListTitle = React.createClass({

  propTypes: {
    update_url: React.PropTypes.string,
    title: React.PropTypes.string,
    show_form: React.PropTypes.bool,
    onDone: React.PropTypes.func,
    authenticity_token: React.PropTypes.string
  },

  getInitialState: function () {
    return {title: this.props.title, is_updating: false, update_failed: false};
  },

  handleTitleChange: function(e) {
    console.log('--handleTitleChange');
    this.setState({title: e.target.value}, this.titleStateUpdated);
  },

  titleStateUpdated: function() {
    console.log('--titleStateUpdated');
  },

  queueUpdateTitle: function (submit_event) {
    submit_event.preventDefault();
    this.setState({is_updating: true, update_failed: false},this.updateTitle);
  },

  updateTitle: function() {
    console.log(JSON.stringify({ authenticity_token: this.props.authenticity_token, shopping_list: { title: this.state.title } }));
    $.ajax({
      url: this.props.update_url,
      dataType: 'json',
      type: 'POST',
      data: { _method: "patch", authenticity_token: this.props.authenticity_token, shopping_list: { title: this.state.title } }
    }).done(function(response) {
      this.setState({title: response.data.title, is_updating: false},this.props.onDone());
    }.bind(this)).fail(function(jqXHR, textStatus, errorThrown) {
      console.log("----- ERROR ----");
      console.log(JSON.stringify(jqXHR));
      console.log(textStatus);
      console.log(errorThrown);
      console.log("----- ----- ----");
      this.setState({is_updating: false, update_failed: true},this.props.onDone());
    }.bind(this));
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    return (<form onSubmit={this.queueUpdateTitle} action={props.update_url}
                  method="post" className="form-inline title-form">
      <input name="_method" value="patch" type="hidden"/>
      <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
      <div className="form-group">
        <h3>
          <label className="sr-only" htmlFor="shopping_list_title">Title</label>
          <input name="shopping_list[title]"
                 id="shopping_list_title"
                 className="form-control"
                 value={state.title}
                 onChange={this.handleTitleChange}
                 style={props.show_form ? null : {display: 'none'}}
                 disabled={state.is_updating}/>
          <span style={props.show_form ? {display: 'none'} : null }>
            {state.title}
          </span>
        </h3>
        <div className="alert alert-danger alert-dismissible" role="alert" style={state.update_failed ? null : {display: 'none'}  }>
          <button type="button" className="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          Update Failed
        </div>
        <button className="btn btn-primary"
                role="button"
                type="submit"
                disabled={state.is_updating}
                style={props.show_form ? null : {display: 'none'}}>Update
        </button>
      </div>
    </form>)
  }

});