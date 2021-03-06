import React from 'react';
import PropTypes from 'prop-types';
const axios = require('axios');
axios.defaults.headers.common['Content-Type'] = 'application/json';
axios.defaults.headers.common['Accept'] = 'application/json';

import ConfirmDelete from '../../lib/confirm_delete';

var createReactClass = require('create-react-class');

const ShoppingListItem = createReactClass({

  propTypes: {
    page: PropTypes.object.isRequired,
    item: PropTypes.object.isRequired,
    authenticity_token: PropTypes.string
  },

  trim: function (str, characters) {
    return str.replace(new RegExp('^' + characters + '+|' + characters + '+$', 'g'), '');
  },

  dasherize: function (str) {
    return this.trim(str).replace(/([A-Z])/g, '-$1').replace(/[-_\s]+/g, '-').toLowerCase();
  },

  getInitialState: function () {
    return {
      amount: this.props.item.amount,
      unit: this.props.item.unit,
      name: this.props.item.name,
      purchased_at: this.props.item.purchased_at,
      updated_at: this.props.item.updated_at,
      is_busy: false,
      is_deleted: false
    };
  },

  UNSAFE_componentWillReceiveProps: function (nextProps) {
    if (nextProps.item.updated_at > this.state.updated_at) {
      this.setState({
        purchased_at: nextProps.item.purchased_at,
        amount: nextProps.item.amount,
        updated_at: nextProps.item.updated_at
      });
    }
  },

  handlePurchasedSubmit: function (button_event) {
    button_event.preventDefault();
    this.setState({is_busy: true});
    var self = this;
    axios.post(this.props.item.purchase_url, {
      authenticity_token: this.props.authenticity_token
    }).then(function (response) {
      self.setState({purchased_at: response.data.data.purchased_at, is_busy: false});
    }).catch(function (error) {
      self.setState({is_busy: false});
      Rollbar.error(error);
    });
  },

  handleUnPurchasedSubmit: function (button_event) {
    button_event.preventDefault();
    this.setState({is_busy: true});
    var self = this;
    axios.delete(this.props.item.unpurchase_url, {
      data: { authenticity_token: this.props.authenticity_token }
    }).then(function (response) {
      self.setState({purchased_at: response.data.data.purchased_at, is_busy: false});
    }).catch(function (error) {
      self.setState({is_busy: false});
      Rollbar.error(error);
    });
  },

  handleDeleteSubmit: function (submit_event) {
    submit_event.preventDefault();
    $("#confirmModal" + this.props.item.id).modal('show');
  },

  handleDelete: function (button_event) {
    button_event.preventDefault();
    $("#confirmModal" + this.props.item.id).modal('hide');
    this.setState({is_busy: true, show_form: false});
    var self = this;
    axios.delete(this.props.item.delete_url, {
      data: { authenticity_token: this.props.authenticity_token }
    }).then(function (response) {
      self.setState({is_deleted: true, is_busy: false});
    }).catch(function (error) {
      self.setState({is_busy: false});
      Rollbar.error(error);
    });
  },

  render: function () {
    var props = this.props;
    var page = this.props.page;
    var state = this.state;
    var category_class = 'category-' + this.dasherize(page.category);
    var show_comparing_price = page.best_entry;
    var best_entry = page.best_entry || {price_per_package: 0, amount: 1, total_price: 0};
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
                  {best_entry.currency_symbol}{best_entry.total_price.toFixed(2)}
                </span>
              </div>
            </span>
          <span className="shopping-actions">
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
