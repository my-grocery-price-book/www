var ShoppingListItem = React.createClass({

  propTypes: {
    amount: React.PropTypes.number,
    unit: React.PropTypes.string,
    name: React.PropTypes.string,
    item_id: React.PropTypes.number,
    purchased_at: React.PropTypes.string,
    update_url: React.PropTypes.string,
    delete_url: React.PropTypes.string,
    purchase_url: React.PropTypes.string,
    unpurchase_url: React.PropTypes.string,
    authenticity_token: React.PropTypes.string
  },

  getInitialState: function () {
    return {amount: this.props.amount,
            unit: this.props.unit,
            name: this.props.name,
            purchased_at: this.props.purchased_at,
            is_busy: false,
            is_deleted: false};
  },

  componentWillReceiveProps: function (nextProps) {
    this.setState({amount: nextProps.amount, unit: nextProps.unit,
                   name: nextProps.name, purchased_at: nextProps.purchased_at});
  },

  handleAmountChange: function(e) {
    this.setState({amount: e.target.value});
  },

  handleUnitChange: function(e) {
    this.setState({unit: e.target.value});
  },

  handleNameChange: function(e) {
    this.setState({unit: e.target.value});
  },

  handlePurchasedSubmit: function (button_event) {
    button_event.preventDefault();
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.purchase_url,
      dataType: 'json',
      type: 'POST',
      data: {"authenticity_token": this.props.authenticity_token},
      success: function (response) {
        this.setState({purchased_at: response.data.purchased_at, is_busy: false});
      }.bind(this),
      error: function () {
        this.setState({is_busy: false});
      }.bind(this)
    });
  },

  handleUnPurchasedSubmit: function (button_event) {
    button_event.preventDefault();
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.unpurchase_url,
      dataType: 'json',
      type: 'DELETE',
      data: {"authenticity_token": this.props.authenticity_token},
      success: function (response) {
        this.setState({purchased_at: response.data.purchased_at, is_busy: false});
      }.bind(this),
      error: function () {
        this.setState({is_busy: false});
      }.bind(this)
    });
  },

  handleDeleteSubmit: function(submit_event) {
    submit_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('show');
  },

  handleDelete: function (button_event) {
    button_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('hide');
    this.setState({is_busy: true, show_form: false});
    $.ajax({
      url: this.props.delete_url,
      dataType: 'json',
      type: 'DELETE',
      data: {"authenticity_token": this.props.authenticity_token},
      success: function () {
        this.setState({is_deleted: true, is_busy: false});
      }.bind(this),
      error: function () {
        this.setState({is_busy: false});
      }.bind(this)
    });
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    return (
        <div data-item-name={state.name}
             className="col-md-6">
          <span className={state.purchased_at ? 'item-purchased' : '' }>
          {state.amount} {state.unit} <span data-name>{state.name}</span>
          </span>
          <form action={props.purchase_url}
                onSubmit={this.handlePurchasedSubmit}
                style={state.purchased_at ? {display: 'none'} : null }
                method="post" className="form-inline form-inline-block">
            <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
            <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
              <span className="sr-only">purchased</span>
              <span className="glyphicon glyphicon-shopping-cart"></span>
            </button>
          </form>
          <form action={props.unpurchase_url}
                onSubmit={this.handleUnPurchasedSubmit}
                style={state.purchased_at ? null : {display: 'none'} }
                method="post" className="form-inline form-inline-block">
            <input name="_method" value="delete" type="hidden"/>
            <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
            <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
              <span className="sr-only">unpurchased</span>
              <span className="glyphicon glyphicon-minus"></span>
            </button>
          </form>
          <ConfirmDelete modal_id={"confirmModal" + props.item_id}
                         ok_handler={this.handleDelete}/>
          <form onSubmit={this.handleDeleteSubmit}
                method="post" className="form-inline form-inline-block">
            <input name="_method" value="delete" type="hidden"/>
            <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
            <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
              <span className="sr-only">delete</span>
              <span className="glyphicon glyphicon-remove"></span>
            </button>
          </form>
        </div> );
  }
});
