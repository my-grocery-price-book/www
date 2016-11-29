import React, { PropTypes } from 'react';

import ConfirmDelete from '../../../lib/confirm_delete';

const ShoppingListItem = React.createClass({

  propTypes: {
    page: React.PropTypes.object.isRequired,
    item: React.PropTypes.object.isRequired,
    authenticity_token: React.PropTypes.string
  },

  trim: function (str, characters) {
    return str.replace(new RegExp('^' + characters + '+|' + characters + '+$', 'g'), '');
  },

  dasherize: function (str) {
    return this.trim(str).replace(/([A-Z])/g, '-$1').replace(/[-_\s]+/g, '-').toLowerCase();
  },

  getInitialState: function () {
    return {amount: this.props.item.amount,
            unit: this.props.item.unit,
            name: this.props.item.name,
            purchased_at: this.props.item.purchased_at,
            updated_at: this.props.item.updated_at,
            is_busy: false,
            is_deleted: false};
  },

  componentWillReceiveProps: function (nextProps) {
    if(nextProps.item.updated_at > this.state.updated_at) {
      this.setState({purchased_at: nextProps.item.purchased_at,
                           amount: nextProps.item.amount,
                       updated_at: nextProps.item.updated_at });
    }
  },

  handleIncreaseAmount: function(event) {
    event.preventDefault();
    this.setState(function(previousState) {
      return {amount: previousState.amount + 1};
    },this.handleAmountUpdate);
  },

  handleDecreaseAmount: function(event) {
    event.preventDefault();
    this.setState(function(previousState) {
      if(previousState.amount > 1) {
        return {amount: previousState.amount - 1};
      } else {
        return {amount: previousState.amount};
      }
    },this.handleAmountUpdate);
  },

  handleAmountUpdate: function () {
    $.ajax({
      url: this.props.item.update_url,
      dataType: 'json',
      type: 'PATCH',
      data: {"authenticity_token": this.props.authenticity_token,
             shopping_list_item: {amount: this.state.amount} },
      success: function (response) {
        this.setState({updated_at: response.data.updated_at,
                       purchased_at: response.data.purchased_at});
      }.bind(this)
    });
  },

  handlePurchasedSubmit: function (button_event) {
    button_event.preventDefault();
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.item.purchase_url,
      dataType: 'json',
      type: 'POST',
      data: {"authenticity_token": this.props.authenticity_token},
      success: function (response) {
        this.setState({purchased_at: response.data.purchased_at, is_busy: false});
      }.bind(this),
      error: function () {
        this.setState({is_busy: false});
      }.bind(this)
    });
  },

  handleUnPurchasedSubmit: function (button_event) {
    button_event.preventDefault();
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.item.unpurchase_url,
      dataType: 'json',
      type: 'DELETE',
      data: {"authenticity_token": this.props.authenticity_token},
      success: function (response) {
        this.setState({purchased_at: response.data.purchased_at, is_busy: false});
      }.bind(this),
      error: function () {
        this.setState({is_busy: false});
      }.bind(this)
    });
  },

  handleDeleteSubmit: function(submit_event) {
    submit_event.preventDefault();
    $("#confirmModal" + this.props.item.id).modal('show');
  },

  handleDelete: function (button_event) {
    button_event.preventDefault();
    $("#confirmModal" + this.props.item.id).modal('hide');
    this.setState({is_busy: true, show_form: false});
    $.ajax({
      url: this.props.item.delete_url,
      dataType: 'json',
      type: 'DELETE',
      data: {"authenticity_token": this.props.authenticity_token},
      success: function () {
        this.setState({is_deleted: true, is_busy: false});
      }.bind(this),
      error: function () {
        this.setState({is_busy: false});
      }.bind(this)
    });
  },

  render: function () {
    var props = this.props;
    var page = this.props.page;
    var state = this.state;
    var category_class = 'category-' + this.dasherize(page.category);
    var show_comparing_price = page.best_entry;
    var best_entry = page.best_entry || {price_per_package: 0, amount: 1};
    var showing_comparing_amount = best_entry.amount > 1;
    
    return (
        <div data-item-name={state.name}
             className="col-xs-12">
          <div className={"shopping-list-item " + "name-" + state.name + " " + category_class}>
            <span className={state.purchased_at ? 'item-name item-purchased' : 'item-info' }>
              <div className="item-name-and-amount">
                <span data-amount className="item-field">{state.amount}</span>
                <span data-name className="item-field item-name">{state.name}</span>
              </div>
              <div className="item-comparing-price">
                <span data-comparing-store style={show_comparing_price ? null : {display: 'none'} }
                        className="item-field item-store">
                  {best_entry.store_name}
                </span>
                <span data-comparing-amount style={showing_comparing_amount ? null : {display: 'none'} }
                      className="item-field item-amount">{best_entry.amount}</span>
                <span style={showing_comparing_amount ? null : {display: 'none'} }
                      className="item-field item-x">x</span>
                <span data-comparing-size style={show_comparing_price ? null : {display: 'none'} }
                    className="item-field item-size">{best_entry.package_size}</span>
                <span data-comparing-unit className="item-field item-unit">{page.unit}</span>
                <span data-comparing-price style={show_comparing_price ? null : {display: 'none'} }
                      className="item-field item-price">
                  {best_entry.currency_symbol}{best_entry.price_per_package.toFixed(2)}
                </span>
              </div>
            </span>
            <span className="shopping-actions">
              <form action={props.item.update_url}
                    onSubmit={this.handleDecreaseAmount}
                    data-amount-change="decrease"
                    method="post" className="form-inline form-inline-block">
                <input name="_method" value="patch" type="hidden"/>
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <input name="shopping_list_item[amount]" value={state.amount - 1} type="hidden"/>
                <button className="btn btn-link" role="button" title="decrease"
                        disabled={state.is_busy || state.is_deleted || state.amount <= 1}>
                  <span className="glyphicon glyphicon-triangle-bottom"></span>
                </button>
              </form>
              <form action={props.item.update_url}
                    onSubmit={this.handleIncreaseAmount}
                    data-amount-change="increase"
                    method="post" className="form-inline form-inline-block">
                <input name="_method" value="patch" type="hidden"/>
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <input name="shopping_list_item[amount]" value={state.amount + 1} type="hidden"/>
                <button className="btn btn-link" role="button" title="increase"
                        disabled={state.is_busy || state.is_deleted}>
                  <span className="glyphicon glyphicon-triangle-top"></span>
                </button>
              </form>
              <form action={props.item.purchase_url}
                    onSubmit={this.handlePurchasedSubmit}
                    style={state.purchased_at ? {display: 'none'} : null }
                    method="post" className="form-inline form-inline-block">
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
                  <span className="sr-only">purchased</span>
                  <span className="glyphicon glyphicon-shopping-cart"></span>
                </button>
              </form>
              <form action={props.item.unpurchase_url}
                    onSubmit={this.handleUnPurchasedSubmit}
                    style={state.purchased_at ? null : {display: 'none'} }
                    method="post" className="form-inline form-inline-block">
                <input name="_method" value="delete" type="hidden"/>
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
                  <span className="sr-only">unpurchased</span>
                  <span className="glyphicon glyphicon-minus"></span>
                </button>
              </form>
              <ConfirmDelete modal_id={"confirmModal" + props.item.id}
                             ok_handler={this.handleDelete}/>
              <form onSubmit={this.handleDeleteSubmit} action={props.item.delete_url}
                    method="post" className="form-inline form-inline-block">
                <input name="_method" value="delete" type="hidden"/>
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
                  <span className="sr-only">delete</span>
                  <span className="glyphicon glyphicon-remove"></span>
                </button>
              </form>
            </span>
          </div>
        </div> );
  }
});

export default ShoppingListItem;
