import React from 'react';
import PropTypes from 'prop-types';

var createReactClass = require('create-react-class');

var ConfirmDelete = createReactClass({

  propTypes: {
    delete_url: PropTypes.string,
    modal_id: PropTypes.string,
    ok_handler: PropTypes.func,
    div_class: PropTypes.string
  },

  getDefaultProps: function() {
    return {
      div_class: 'modal fade'
    };
  },

  render: function () {
    return (
        <div className={this.props.div_class}
             id={this.props.modal_id}
             tabIndex="-1"
             role="dialog"
             aria-labelledby="myModalLabel">
          <div className="modal-dialog" role="document">
            <div className="modal-content">
              <div className="modal-header">
                <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 className="modal-title" id="myModalLabel">Are you sure?</h4>
              </div>
              <div className="modal-body">
                <p>Are you sure you want to delete this?</p>
              </div>
              <div className="modal-footer">
                <button onClick={this.props.ok_handler}
                        type="button"
                        className="btn btn-primary">
                  OK
                </button>
                <button type="button" className="btn btn-default" data-dismiss="modal">Cancel</button>
              </div>
            </div>
          </div>
        </div>
    );
  }
});

export default ConfirmDelete;