var EntriesForm = React.createClass({

  propTypes: {
    entry: React.PropTypes.object,
    package_unit: React.PropTypes.string,
    back_href: React.PropTypes.string,
    new_store_href: React.PropTypes.string,
    error_messages:  React.PropTypes.arrayOf(React.PropTypes.string),
    selectable_stores:  React.PropTypes.arrayOf(React.PropTypes.arrayOf(React.PropTypes.string)),
    authenticity_token: React.PropTypes.string
  },

  getInitialState: function () {
    const entry = this.props.entry;
    return {total_price: entry.total_price, date_on: entry.date_on,
            product_name: entry.product_name, amount: entry.amount,
            package_size: entry.package_size};
  },

  handleStoreIDChange: function (e) {
    this.setState({store_id: e.target.value});
  },

  handleDateOnChange: function (e) {
    this.setState({date_on: e.target.value});
  },

  handleProductNameChange: function (e) {
    this.setState({product_name: e.target.value});
  },

  handleAmountChange: function (e) {
    this.setState({amount: e.target.value});
  },

  handlePackageSizeChange: function (e) {
    this.setState({package_size: e.target.value});
  },

  handleTotalPriceChange: function (e) {
    this.setState({total_price: e.target.value});
  },

  render: function () {
    const props = this.props;
    const state = this.state;
    var rendered_errors = null;

    if (this.props.error_messages.length > 0) {
      var i = 0;
      const all_errors = this.props.error_messages.map(function (message) {
        i += 1;
        return (
            <option key={"message_" + i}>{message}</option>
        );
      });
      rendered_errors = <div className="error-explanation">
        <ul>{all_errors}</ul>
      </div>;
    }

    const rendered_store_options = this.props.selectable_stores.map(function (store_option) {
      return (
          <option key={"store" + store_option[1]} value={store_option[1]}>
            {store_option[0]}
          </option>
      );
    });


    return <form action={props.create_url} method="post">
      <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
      {rendered_errors}
      <div className="form-group">
        <label htmlFor="store_id">Store</label>
        <select id="store_id" name="price_entry[store_id]" className="form-control"
                onChange={this.handleStoreIDChange}>
          {rendered_store_options}
        </select>
        <a href={props.new_store_href}>New Store</a>
      </div>
      <div className="form-group">
        <label htmlFor="date_on">Date on</label>
        <input name="price_entry[date_on]" className="form-control"
               value={state.date_on} onChange={this.handleDateOnChange}
               id="date_on" type="date" required/>
      </div>
      <div className="form-group">
        <label htmlFor="product_name">Product name</label>
        <input name="price_entry[product_name]" className="form-control"
               value={state.product_name} onChange={this.handleProductNameChange}
               id="product_name" required/>
      </div>
      <div className="form-group">
        <label htmlFor="amount">Amount</label>
        <input name="price_entry[amount]" className="form-control"
               value={state.amount} onChange={this.handleAmountChange}
               id="amount" type="number" min="1" required/>
      </div>
      <div className="form-group">
        <label htmlFor="package_size">Package size</label>
        <div className="input-group">
          <input name="price_entry[package_size]" className="form-control"
                 value={state.package_size} onChange={this.handlePackageSizeChange}
                 id="package_size" type="number" min="1" aria-describedby="package_unit" required/>
          <span className="input-group-addon" id="package_unit">{props.package_unit}</span>
        </div>
      </div>
      <div className="form-group">
        <label htmlFor="total_price">Total price</label>
        <input name="price_entry[total_price]" className="form-control"
               value={state.total_price} onChange={this.handleTotalPriceChange}
               id="total_price" type="number" min="0" step="0.01" required/>
      </div>
      <button className="btn btn-primary">Save</button>
      <a href={props.back_href} className="btn btn-default">Back</a>
    </form>;
  }
});