import React from 'react';
import PropTypes from 'prop-types';


import ShoppingList from './shopping_list';

var createReactClass = require('create-react-class');

var ShoppingListIndex = createReactClass({

  propTypes: {
    initial_lists: PropTypes.arrayOf(PropTypes.object),
    create_url: PropTypes.string,
    latest_url: PropTypes.string,
    authenticity_token: PropTypes.string
  },

  getInitialState: function () {
    return {lists: this.props.initial_lists};
  },

  render: function () {
    var vm = this;

    var render_lists = this.state.lists.map(function (list) {
      return (
          <ShoppingList key={"list_" + list.id}
                        update_url={list.update_url}
                        delete_url={list.delete_url}
                        items_url={list.items_url}
                        item_id={list.id}
                        title={list.title}
                        item_progress={list.item_progress}
                        authenticity_token={vm.props.authenticity_token}/>
      );
    });

    return <div>
      <div className="row">
        <div className="col-md-12">
          <h1>Shopping Lists</h1>
          <form action={this.props.create_url} method="post" className="form-inline form-inline-block">
            <input name="authenticity_token" value={this.props.authenticity_token} type="hidden"/>
            <button className='btn btn-default btn-xs'>New Shopping List</button>
          </form>
          { this.state.is_busy_creating ? <span className="glyphicon glyphicon-refresh glyphicon-refresh-animate"
                                                aria-hidden="true"></span> : null }
          <a className="btn btn-default btn-xs" href={this.props.latest_url}>Latest Shopping List</a>
        </div>
      </div>
      <div className="row">
        {render_lists}
      </div>
    </div>;
  }
});

export default ShoppingListIndex;