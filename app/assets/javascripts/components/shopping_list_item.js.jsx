var ShoppingListItem = React.createClass({

  propTypes: {
    amount: React.PropTypes.number,
    unit: React.PropTypes.string,
    name: React.PropTypes.string
  },

  render: function() {
    return <div>{this.props.amount} {this.props.unit} {this.props.name}</div>;
  }
});
