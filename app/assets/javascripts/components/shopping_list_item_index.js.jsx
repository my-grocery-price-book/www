var ShoppingListItemIndex = React.createClass({

  propTypes: {
    initialList: React.PropTypes.arrayOf(React.PropTypes.object),
    shoppingList: React.PropTypes.object,
    createUrl: React.PropTypes.string,
    authenticityToken: React.PropTypes.string
  },

  getInitialState: function () {
    return {list: this.props.initialList, show_form: false};
  },

  editTitle: function () {
    this.setState({show_form: true});
  },

  editTitleDone: function () {
    this.setState({show_form: false});
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

  render: function () {
    var state = this.state;
    var props = this.props;

    var render_list = this.state.list.map(function (item) {
      return (
        <div key={"item_" + item.id} className="col-xs-12">
          {item.amount} {item.unit} {item.name}
        </div>
      );
    });

    return <div>
      <div className="row">
        <div className="col-xs-12">
          <ShoppingListTitle update_url={props.shoppingList.update_url}
                             show_form={state.show_form}
                             title={props.shoppingList.title}
                             authenticityToken={props.authenticityToken}
                             onDone={this.editTitleDone}/>
          <button className="btn btn-default btn-xs"
                  role="button"
                  onClick={this.editTitle}
                  style={state.show_form ? {display: 'none'} : null }
                  type="submit">Edit</button>
        </div>
      </div>
      <div className="row">
        {render_list}
      </div>
      <div className="row">
        <form action={this.props.createUrl} method="post">
          <div className="form-group">
            <input name="authenticity_token" value={this.props.authenticityToken} type="hidden"/>
            <div className="col-xs-5 nopadding">
              <input name="shopping_list_item[name]" className="form-control"
                     value={state.name} onChange={this.handleNameChange}
                     disabled={state.is_adding} placeholder="name"/>
            </div>
            <div className="col-xs-3 nopadding">
              <input name="shopping_list_item[unit]" className="form-control col-xs-3"
                     value={state.unit} onChange={this.handleUnitChange}
                     disabled={state.is_adding} placeholder="unit"/>
            </div>
            <div className="col-xs-2 nopadding">
              <input name="shopping_list_item[amount]" className="form-control"
                     value={state.amount} onChange={this.handleAmountChange} type="number"
                     min="1"
                     disabled={state.is_adding} placeholder="amount"/>
            </div>
            <div className="col-xs-1 nopadding">
              <button className='btn btn-primary'><span className="glyphicon glyphicon-plus"></span></button>
            </div>
          </div>
        </form>
      </div>
    </div>;
  }
});
