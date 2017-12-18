import React from 'react';
import PropTypes from 'prop-types';

import ConfirmDelete from '../../lib/confirm_delete';
import ShoppingListTitle from './shopping_list_title';

var createReactClass = require('create-react-class');

var ShoppingList = createReactClass({

  propTypes: {
    update_url: PropTypes.string,
    delete_url: PropTypes.string,
    items_url: PropTypes.string,
    item_id: PropTypes.string,
    title: PropTypes.string,
    item_progress: PropTypes.string,
    authenticity_token: PropTypes.string
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
    // $("#confirmModal" + this.props.item_id).modal('show');
  },

  handleDelete: function (button_event) {
    button_event.preventDefault();
    // $("#confirmModal" + this.props.item_id).modal('hide');
    this.setState({is_busy: true, show_form: false},this.doDelete);
  },

  doDelete: function() {
    var self = this;
    axios.delete(this.props.delete_url, {
      authenticity_token: this.props.authenticity_token
    }).then(function (response) {
      self.setState({is_deleted: true, is_busy: false});
    }).catch(function (error) {
      self.setState({is_busy: false});
      Rollbar.error(error);
    });
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

export default ShoppingList;