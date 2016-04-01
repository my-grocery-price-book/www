var ShoppingListItemIndex = React.createClass({

  propTypes: {
    initial_items: React.PropTypes.arrayOf(React.PropTypes.object),
    shopping_list: React.PropTypes.object,
    create_url: React.PropTypes.string,
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

  handleNameChange: function (e) {
    this.setState({name: e.target.value});
  },

  handleAmountChange: function (e) {
    this.setState({amount: e.target.value});
  },

  handleUnitChange: function (e) {
    this.setState({unit: e.target.value});
  },

  componentDidMount: function() {
    setTimeout(this.loadItemsFromServer, 5000);
  },

  addItem: function (submit_event) {
    submit_event.preventDefault();
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.create_url,
      dataType: 'json',
      type: 'POST',
      data: {
        authenticity_token: this.props.authenticity_token,
        shopping_list_item: {name: this.state.name, amount: this.state.amount, unit: this.state.unit}
      },
      success: function (response) {
        var new_items = this.state.items.slice();
        new_items.push(response.data);
        this.setState({name: '', amount: '', unit: '', is_busy: false, items: new_items});
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
        </div>
      </div>
      <div className="row">
        <ReactCSSTransitionGroup transitionName="shopping-list-item" transitionEnterTimeout={500} transitionLeaveTimeout={300}>
          {rendered_items}
        </ReactCSSTransitionGroup>
      </div>
      <div className="row">
        <form onSubmit={this.addItem} action={props.create_url} method="post">
          <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
          <div className="col-xs-5 no-right-padding">
            <label className="sr-only" htmlFor="shopping_list_item_name">Item name</label>
            <input name="shopping_list_item[name]" className="form-control"
                   value={state.name} onChange={this.handleNameChange}
                   disabled={state.is_busy} placeholder="name"
                   id="shopping_list_item_name"/>
          </div>
          <div className="col-xs-3 nopadding">
            <label className="sr-only" htmlFor="shopping_list_item_unit">Unit</label>
            <input name="shopping_list_item[unit]" className="form-control col-xs-3"
                   value={state.unit} onChange={this.handleUnitChange}
                   disabled={state.is_busy} placeholder="unit"
                   id="shopping_list_item_unit"/>
          </div>
          <div className="col-xs-2 nopadding">
            <label className="sr-only" htmlFor="shopping_list_item_amount">Amount</label>
            <input name="shopping_list_item[amount]" className="form-control"
                   value={state.amount} onChange={this.handleAmountChange} type="number"
                   min="1" id="shopping_list_item_amount"
                   disabled={state.is_busy} placeholder="amount"/>
          </div>
          <div className="col-xs-1 no-left-padding">
            <button className='btn btn-primary' disabled={state.is_busy}>
              <span className="sr-only">Add</span>
              <span className="glyphicon glyphicon-plus"></span>
            </button>
          </div>
        </form>
      </div>
    </div>;
  }
});
