var ShoppingListItem = React.createClass({

  propTypes: {
    item: React.PropTypes.object,
    createUrl: React.PropTypes.string,
    authenticityToken: React.PropTypes.string
  },

  itemState: function(item) {
    return {id: item.id, name: item.name, amount: item.amount, unit: item.unit};
  },

  getInitialState: function() {
    return this.itemState(this.props.item);
  },

  componentDidMount: function(){
    if(!this.state.id) {
      $.ajax({
        url: this.props.createUrl,
        dataType: 'json',
        type: 'POST',
        data: {"authenticity_token": this.props.authenticityToken, "shopping_list_item": this.state},
        success: function (data) {
          this.setState(this.itemState(data));
        }.bind(this),
        error: function (xhr, status, err) {
          console.error(status, err.toString());
        }.bind(this)
      });
    }
  },

  render: function() {
    return <div data-item-id={this.state.id}>{this.state.amount} {this.state.unit} {this.state.name}</div>;
  }
});
