import React from 'react';
import PropTypes from 'prop-types';

var createReactClass = require('create-react-class');

var ShoppingListTitle = createReactClass({

  propTypes: {
    update_url: PropTypes.string,
    title: PropTypes.string,
    show_form: PropTypes.bool,
    onDone: PropTypes.func,
    authenticity_token: PropTypes.string
  },

  getInitialState: function () {
    return {title: this.props.title, is_updating: false, update_failed: false};
  },

  handleTitleChange: function(e) {
    this.setState({title: e.target.value});
  },

  queueUpdateTitle: function (submit_event) {
    submit_event.preventDefault();
    this.setState({is_updating: true, update_failed: false},this.updateTitle);
  },

  updateTitle: function() {
    var self = this;
    axios.patch(this.props.update_url, {
      authenticity_token: this.props.authenticity_token, shopping_list: {title: this.state.title}
    }).then(function (response) {
      self.setState({title: response.data.data.title, is_updating: false},self.props.onDone());
    }).catch(function (error) {
      self.setState({is_updating: false, update_failed: true},self.props.onDone());
      Rollbar.error(error);
    });
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    if(props.show_form) {
      return (<form onSubmit={this.queueUpdateTitle} action={props.update_url}
                    method="post" className="form-inline title-form">
        <input name="_method" value="patch" type="hidden"/>
        <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
        <div className="form-group">
          <input name="shopping_list[title]"
                 id="shopping_list_title"
                 className="form-control"
                 value={state.title}
                 onChange={this.handleTitleChange}
                 placeholder="Title"
                 disabled={state.is_updating}/>
          <div className="alert alert-danger alert-dismissible" role="alert" style={state.update_failed ? null : {display: 'none'}  }>
            <button type="button" className="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
            Update Failed
          </div>
          <button className="btn btn-primary"
                  role="button"
                  type="submit"
                  disabled={state.is_updating}>Update
          </button>
        </div>
      </form>)
    } else {
      return <h3><span id="shopping_list_title_span">{state.title}</span></h3>
    }
  }

});

export default ShoppingListTitle;