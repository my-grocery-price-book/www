var EntriesForm = React.createClass({

  propTypes: {
    entry: React.PropTypes.object,
    package_unit: React.PropTypes.string,
    back_href: React.PropTypes.string,
    new_store_href: React.PropTypes.string,
    form_action: React.PropTypes.string,
    form_method: React.PropTypes.string,
    error_messages:  React.PropTypes.arrayOf(React.PropTypes.string),
    local_suggestions:  React.PropTypes.arrayOf(React.PropTypes.string),
    selectable_stores:  React.PropTypes.arrayOf(React.PropTypes.arrayOf(React.PropTypes.string)),
    bloodhoundBuilder: React.PropTypes.func,
    authenticity_token: React.PropTypes.string
  },

  getInitialState: function () {
    const entry = this.props.entry;
    return {total_price: entry.total_price, date_on: entry.date_on, 
            store_id: entry.store_id.toString(), product_name: entry.product_name, 
            amount: entry.amount, package_size: entry.package_size, bloodhound_initialized: false,
            suggestions: [], more_suggestions: []};
  },

  handleStoreIDChange: function (e) {
    this.setState({store_id: e.target.value});
  },

  handleDateOnChange: function (e) {
    this.setState({date_on: e.target.value});
  },

  setProductNameFromSuggestion: function (click_event) {
    click_event.preventDefault();
    var new_name = click_event.currentTarget.textContent;
    this.setState({product_name: new_name, suggestions: [], more_suggestions: []});
  },

  handleProductNameChange: function (e) {
    this.findSuggestions(e.target.value);
    this.setState({product_name: e.target.value});
  },

  findSuggestions: function(name) {
    if (this.state.bloodhound_initialized) {
      this.bloodhound.search(name,
          this.handleNameSuggestions,
          this.handleAdditionalNameSuggestions)
    }
  },

  handleNameSuggestions: function (suggested_names) {
    this.setState({suggestions: suggested_names});
  },

  handleAdditionalNameSuggestions: function (suggested_names) {
    this.setState({more_suggestions: suggested_names});
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

  componentDidMount: function () {
    this.loadBloodhound();
  },

  loadBloodhound: function () {
    var bloodhoundBuilder = this.props.bloodhoundBuilder || window.EntriesBloodhound;
    this.bloodhound = bloodhoundBuilder(this.props.local_suggestions);
    this.bloodhound.initialize().done(this.bloodhoundInitialized);
  },

  bloodhoundInitialized: function () {
    this.setState({bloodhound_initialized: true});
  },

  render: function () {
    const props = this.props;
    const state = this.state;
    const component = this;

    var rendered_errors = null;

    if (this.props.error_messages.length > 0) {
      var i = 0;
      const all_errors = this.props.error_messages.map(function (message) {
        i += 1;
        return (
            <li key={"message_" + i}>{message}</li>
        );
      });
      rendered_errors = <div className="error-explanation">
        <ul>{all_errors}</ul>
      </div>;
    }

    const rendered_store_options = this.props.selectable_stores.map(function (store_option) {
      return (
          <option key={"store" + store_option[1]}
                  value={store_option[1]}>
            {store_option[0]}
          </option>
      );
    });

    var suggestions = this.state.suggestions.concat(this.state.more_suggestions).slice(0,3);
    if(state.product_name == "") {
      suggestions = [];
    }

    suggestions.reverse();

    var rendered_suggestions = suggestions.map(function (name) {
      return (
          <button className="bg-info name-suggestion btn" key={"suggested-" + name}
                  onClick={component.setProductNameFromSuggestion}>
            {name}
          </button>
      );
    });


    return <form action={props.form_action} method="post">
      <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
      <input name="_method" value={props.form_method} type="hidden"/>
      {rendered_errors}
      <div className="form-group">
        <label className="sr-only" htmlFor="store_id">Store</label>
        <select id="store_id" name="price_entry[store_id]" className="form-control"
                onChange={this.handleStoreIDChange} value={state.store_id}>
          <option>Select a store</option>
          {rendered_store_options}
        </select>
        <a href={props.new_store_href} className="btn btn-default">New Store</a>
      </div>
      <div className="form-group">
        <label className="sr-only" htmlFor="date_on">Date on</label>
        <input name="price_entry[date_on]" className="form-control"
               value={state.date_on} onChange={this.handleDateOnChange}
               id="date_on" type="date" required placeholder="Date on"/>
      </div>
      <div className="form-group" style={{position: "relative"}}>
        <label className="sr-only" htmlFor="product_name">Product name</label>
        <div className="col-xs-12 shopping-list-suggestions">
          <ReactCSSTransitionGroup transitionName="shopping-list-item" transitionEnterTimeout={250}
                                   transitionLeaveTimeout={250}>
            {rendered_suggestions}
          </ReactCSSTransitionGroup>
        </div>
        <input name="price_entry[product_name]" className="form-control"
               value={state.product_name} onChange={this.handleProductNameChange}
               id="product_name" required placeholder="Product name"
               autoComplete={state.bloodhound_initialized ? 'off' : 'on'} />
      </div>
      <div className="form-group">
        <label className="sr-only" htmlFor="amount">Amount</label>
        <input name="price_entry[amount]" className="form-control"
               value={state.amount} onChange={this.handleAmountChange}
               id="amount" type="number" min="1" required placeholder="Amount"/>
      </div>
      <div className="form-group">
        <label className="sr-only" htmlFor="package_size">Package size</label>
        <div className="input-group">
          <input name="price_entry[package_size]" className="form-control"
                 value={state.package_size} onChange={this.handlePackageSizeChange}
                 id="package_size" type="number" min="1" aria-describedby="package_unit"
                 required placeholder="Package size"/>
          <span className="input-group-addon" id="package_unit">{props.package_unit}</span>
        </div>
      </div>
      <div className="form-group">
        <label className="sr-only" htmlFor="total_price">Total price</label>
        <input name="price_entry[total_price]" className="form-control"
               value={state.total_price} onChange={this.handleTotalPriceChange}
               id="total_price" type="number" min="0" step="0.01" required
               placeholder="Total price"/>
      </div>
      <button className="btn btn-primary">Save</button>
      <a href={props.back_href} className="btn btn-default">Back</a>
    </form>;
  }
});