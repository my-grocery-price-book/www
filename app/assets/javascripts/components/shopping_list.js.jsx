var ShoppingList = React.createClass({
  propTypes: {
    createdOn: React.PropTypes.node,
    itemsUrl: React.PropTypes.string,
    authenticityToken: React.PropTypes.string,
    initialItems: React.PropTypes.arrayOf(React.PropTypes.object)
  },

  getInitialState: function() {
    return {items: this.props.initialItems};
  },

  handleItemSubmit: function(item) {
    var new_items = this.state.items.slice();
    new_items.push(item);
    this.setState({ items: new_items });
  },

  render: function() {
    var itemsUrl = this.props.itemsUrl;
    var authenticityToken = this.props.authenticityToken;

    var itemNodes = this.state.items.map(function(item, i) {
      return (
          <ShoppingListItem key={"item_" + i}
                            item={item}
                            createUrl={itemsUrl}
                            authenticityToken={authenticityToken} />
      );
    });
    return (
        <div className="shoppingList">
          <div className="row">
            <div className="col-md-12">
              <h1>Shopping List {this.props.createdOn}</h1>
            </div>
          </div>
          <div>{itemNodes}</div>
          <ShoppingListNewItemForm
              action={this.props.action}
              onItemSubmit={this.handleItemSubmit} />
        </div>
    );
  }
});
