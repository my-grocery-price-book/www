var ShoppingListItemIndex = React.createClass({

  propTypes: {
    initial_items: React.PropTypes.arrayOf(React.PropTypes.object),
    shopping_list: React.PropTypes.object,
    create_url: React.PropTypes.string,
    create_list_url: React.PropTypes.string,
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

  handleNameSuggestions: function (book_pages) {
    var names = book_pages.map(function(book_page) {
      return book_page.name;
    });
    this.setState({name_suggestions: names});
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
      error: function () {
        setTimeout(this.loadItemsFromServer, 60000);
      }.bind(this)
    });
  },

  render: function () {
    var state = this.state;
    var props = this.props;

    var rendered_items = this.state.items.map(function (item) {
      return (
          <ShoppingListItem key={"item_" + item.id}
                            item_id={item.id}
                            amount={item.amount}
                            unit={item.unit}
                            name={item.name}
                            purchased_at={item.purchased_at}
                            update_url={item.update_url}
                            delete_url={item.delete_url}
                            purchase_url={item.purchase_url}
                            unpurchase_url={item.unpurchase_url}
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
          <form action={this.props.create_list_url} method="post" className="form-inline form-inline-block">
            <input name="authenticity_token" value={this.props.authenticity_token} type="hidden"/>
            <button className='btn btn-default btn-xs'>New Shopping List</button>
          </form>
        </div>
      </div>
      <div className="row">
        <ReactCSSTransitionGroup transitionName="shopping-list-item" transitionEnterTimeout={500} transitionLeaveTimeout={500}>
          {rendered_items}
        </ReactCSSTransitionGroup>
      </div>
      <div className="row">
        <ShoppingListItemAddForm handleAdd={this.addItem}
                                 create_url={props.create_url}
                                 price_book_pages_url={props.shopping_list.price_book_pages_url}
                                 authenticity_token={props.authenticity_token}
                                 disabled={state.is_busy} />
      </div>
    </div>;
  }
});
