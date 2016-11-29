import React, { PropTypes } from 'react';

import ShoppingListItemAddForm from '../components/shopping_list_item_add_form';
import ShoppingListTitle from '../components/shopping_list_title';
import ShoppingListItem from '../components/shopping_list_item';

const ShoppingListItemIndex = React.createClass({
  page_matches: {},

  propTypes: {
    initial_items: React.PropTypes.arrayOf(React.PropTypes.object),
    pages: React.PropTypes.arrayOf(React.PropTypes.object),
    shopping_list: React.PropTypes.object,
    create_url: React.PropTypes.string,
    create_list_url: React.PropTypes.string,
    all_lists_url: React.PropTypes.string,
    authenticity_token: React.PropTypes.string
  },

  getInitialState: function () {
    return {items: this.props.initial_items, show_title_form: false};
  },

  editTitle: function () {
    this.setState({show_title_form: true});
  },

  editTitleDone: function () {
    this.setState({show_title_form: false});
  },

  componentDidMount: function() {
    setTimeout(this.loadItemsFromServer, 5000);
  },


  addItem: function (name) {
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.create_url,
      dataType: 'json',
      type: 'POST',
      data: {
        authenticity_token: this.props.authenticity_token,
        shopping_list_item: {name: name}
      },
      success: function (response) {
        var new_items = this.state.items.slice();
        new_items.push(response.data);
        this.setState({is_busy: false, items: new_items});
      }.bind(this),
      error: function () {
        this.setState({is_busy: false});
      }.bind(this)
    });
  },

  reloadItems: function (click_event) {
    click_event.preventDefault();
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.shopping_list.items_url,
      dataType: 'json',
      type: 'GET',
      success: function (response) {
        this.setState({items: response.data, is_busy: false});
      }.bind(this),
      error: function () {
        location.reload();
      }.bind(this)
    });
  },

  loadItemsFromServer: function () {
    $.ajax({
      url: this.props.shopping_list.items_url,
      dataType: 'json',
      type: 'GET',
      success: function (response) {
        this.setState({items: response.data});
        setTimeout(this.loadItemsFromServer, 5000);
      }.bind(this),
      error: function (xhr, ajaxOptions, thrownError) {
        setTimeout(this.loadItemsFromServer, 60000);
        Rollbar.error("Shopping list sync failed:" + xhr.responseText, thrownError);
      }.bind(this)
    });
  },

  getMatchingPage: function (item) {
    if(this.page_matches[item.id]) {
      return this.page_matches[item.id];
    }

    this.page_matches[item.id] = {category: 'Other'};
    var self = this;

    var item_name = item.name.toLowerCase();

    this.props.pages.map(function (page) {
      if(page.name.toLowerCase() == item_name) {
        self.page_matches[item.id] = page;
        return;
      } else if(page.product_names.includes(item_name)) {
        self.page_matches[item.id] = page;
        return;
      }
    });

    return this.page_matches[item.id];
  },

  render: function () {
    var state = this.state;
    var props = this.props;
    var self = this;

    var rendered_items = this.state.items.map(function (item) {
      var page = self.getMatchingPage(item);
      return (
          <ShoppingListItem key={"item_" + item.id}
                            page={page}
                            item={item}
                            authenticity_token={props.authenticity_token}/>
      );
    });

    return <div>
      <div className="row">
        <div className="col-xs-12">
          <ShoppingListTitle update_url={props.shopping_list.update_url}
                             show_form={state.show_title_form}
                             title={props.shopping_list.title}
                             authenticity_token={props.authenticity_token}
                             onDone={this.editTitleDone}/>
          <button className="btn btn-default btn-xs"
                  role="button"
                  onClick={this.editTitle}
                  style={state.show_title_form ? {display: 'none'} : null }
                  type="submit">Edit Title
          </button>
          <a onClick={this.reloadItems}
             href={props.shopping_list.items_url}
             disabled={state.is_busy}
             className="btn btn-default btn-xs">
            Refresh
          </a>
          <a href={props.all_lists_url}
             className="btn btn-default btn-xs">
            Previous Lists
          </a>
          <form action={this.props.create_list_url} method="post" className="form-inline form-inline-block">
            <input name="authenticity_token" value={this.props.authenticity_token} type="hidden"/>
            <button className='btn btn-default btn-xs'>New Shopping List</button>
          </form>
        </div>
      </div>
      <div className="row">
        {rendered_items}
      </div>
      <div className="row">
        <ShoppingListItemAddForm handleAdd={this.addItem}
                                 create_url={props.create_url}
                                 price_book_pages_url={props.shopping_list.price_book_pages_url}
                                 item_names_url={props.shopping_list.item_names_url}
                                 authenticity_token={props.authenticity_token}
                                 disabled={state.is_busy} />
      </div>
    </div>;
  }
});

export default ShoppingListItemIndex;