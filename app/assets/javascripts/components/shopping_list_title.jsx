var ShoppingListTitle = React.createClass({

  propTypes: {
    update_url: React.PropTypes.string,
    title: React.PropTypes.string,
    show_form: React.PropTypes.bool,
    onDone: React.PropTypes.func,
    authenticityToken: React.PropTypes.string
  },

  getInitialState: function () {
    return {title: this.props.title, is_updating: false};
  },

  handleTitleChange: function(e) {
    this.setState({title: e.target.value});
  },

  updateTitle: function (submit_event) {
    submit_event.preventDefault();
    this.setState({is_updating: true});
    $.ajax({
      url: this.props.update_url,
      dataType: 'json',
      type: 'PATCH',
      data: {"authenticity_token": this.props.authenticityToken, shopping_list: {title: this.state.title }},
      success: function (response) {
        this.setState({title: response.data.title, is_updating: false});
        this.props.onDone();
      }.bind(this),
      error: function (xhr, status, err) {
        this.setState({is_updating: false});
        this.props.onDone();
        console.error(status, err.toString());
      }.bind(this)
    });
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    return (<form onSubmit={this.updateTitle} action={props.update_url}
                  method="post" className="form-inline title-form">
      <input name="_method" value="patch" type="hidden"/>
      <input name="authenticity_token" value={props.authenticityToken} type="hidden"/>
      <div className="form-group">
        <h3>
          <input name="shopping_list[title]"
                 className="form-control"
                 value={state.title}
                 onChange={this.handleTitleChange}
                 style={props.show_form ? null : {display: 'none'}}
                 disabled={state.is_updating}/>
          <span style={props.show_form ? {display: 'none'} : null }>
            {state.title}
          </span>
        </h3>
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