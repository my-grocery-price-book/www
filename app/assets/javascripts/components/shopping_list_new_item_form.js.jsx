var ShoppingListNewItemForm = React.createClass({
  propTypes: {
  },
  getInitialState: function() {
    return {name: '', amount: 1, unit: ''};
  },
  handleNameChange: function(e) {
    this.setState({name: e.target.value});
  },
  handleAmountChange: function(e) {
    this.setState({amount: e.target.value});
  },
  handleUnitChange: function(e) {
    this.setState({unit: e.target.value});
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var name = this.state.name;
    var amount = this.state.amount;
    var unit = this.state.unit;
    this.props.onItemSubmit({name: name, amount: amount, unit: unit});
    this.setState({name: '', amount: 1, unit: ''});
  },

  render: function () {
    return (
        <div className="row">
          <div className="col-sm-12">
            <form onSubmit={this.handleSubmit} className="form-inline">
              <div className="form-group">
                <label className="sr-only" for="shopping_list_item_name">Item name</label>
                <input className="form-control"
                       name="shopping_list_item[name]"
                       id="shopping_list_item_name"
                       placeholder="Item name"
                       value={this.state.name}
                       onChange={this.handleNameChange} />
              </div>
              <div className="form-group">
                <label className="sr-only" for="shopping_list_item_amount">Amount</label>
                <input type="number"
                       className="form-control"
                       name="shopping_list_item[amount]"
                       id="shopping_list_item_amount"
                       placeholder="Amount"
                       value={this.state.amount}
                       onChange={this.handleAmountChange} />
              </div>
              <div className="form-group">
                <label className="sr-only" for="shopping_list_item_unit">Unit</label>
                <input type="text"
                       className="form-control"
                       name="shopping_list_item[unit]"
                       id="shopping_list_item_unit"
                       placeholder="Unit"
                       value={this.state.unit}
                       onChange={this.handleUnitChange} />
              </div>
              <button className='btn btn-default'>Add</button>
              <a href="/shopping_lists">Back</a>
            </form>
          </div>
        </div>
    );
  }
});
