var ShoppingList = React.createClass({
  propTypes: {
    createdOn: React.PropTypes.node,
    action: React.PropTypes.string,
    items_url: React.PropTypes.string,
    authenticityToken: React.PropTypes.string,
    initial_items: React.PropTypes.arrayOf(React.PropTypes.object)
  },

  getInitialState: function() {
    return {items: this.props.initial_items};
  },

  handleItemSubmit: function(item) {
    // TODO: submit to the server and refresh the list
    console.info(item);
    var new_items = this.state.items.slice()
    new_items.push(item)
    this.setState({ items: new_items })
    //$.ajax({
    //  url: this.props.items_url,
    //  dataType: 'json',
    //  type: 'POST',
    //  data: item,
    //  success: function(data) {
    //    this.setState({data: data});
    //  }.bind(this),
    //  error: function(xhr, status, err) {
    //    console.error(this.props.items_url, status, err.toString());
    //  }.bind(this)
    //});
  },

  render: function() {
    var itemNodes = this.state.items.map(function(item) {
      return (
          <ShoppingListItem key={item.id} amount={item.amount} unit={item.unit} name={item.name}/>
      );
    });
    return (
        <div className="shoppingList">
          <div className="row">
            <div className="col-md-12">
              <h1>Shopping List {this.props.createdOn}</h1>
            </div>
          </div>
          <ShoppingListNewItemForm
              action={this.props.action}
              authenticityToken={this.props.authenticityToken}
              onItemSubmit={this.handleItemSubmit} />
          <div>{itemNodes}</div>
        </div>
    );
  }
});
