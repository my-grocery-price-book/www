var ShoppingListItem = React.createClass({

  propTypes: {
    amount: React.PropTypes.number,
    unit: React.PropTypes.string,
    name: React.PropTypes.string,
    item_id: React.PropTypes.number,
    purchased_at: React.PropTypes.object,
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
            is_busy: false,
            is_deleted: false};
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

  handlePurchasedSubmit: function(submit_event) {
    submit_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('show');
  },

  handlePurchase: function (button_event) {
    button_event.preventDefault();
    $("#confirmModal" + this.props.item_id).modal('hide');
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.delete_url,
      dataType: 'json',
      type: 'DELETE',
      data: {"authenticity_token": this.props.authenticity_token, shopping_list: {title: this.state.title }},
      success: function (response) {
        console.info(response);
        this.setState({is_deleted: true, is_busy: false});
      }.bind(this),
      error: function (xhr, status, err) {
        this.setState({is_busy: false});
        console.error(status, err.toString());
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
      success: function (response) {
        console.info(response);
        this.setState({is_deleted: true, is_busy: false});
      }.bind(this),
      error: function (xhr, status, err) {
        this.setState({is_busy: false});
        console.error(status, err.toString());
      }.bind(this)
    });
  },

  render: function () {
    var props = this.props;
    var state = this.state;

    return (
        <div style={state.is_deleted ? {display: 'none'} : null }
             className="col-md-6">
          {state.amount} {state.unit} {state.name}
          <ConfirmDelete modal_id={"confirmModal" + props.item_id}
                         ok_handler={this.handleDelete}/>
          <form onSubmit={this.handleDeleteSubmit} action={props.delete_url}
                method="post" className="form-inline form-inline-block">
            <input name="_method" value="delete" type="hidden"/>
            <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
            <button className="btn btn-link" role="button">
              <span className="glyphicon glyphicon-remove"></span>
            </button>
          </form>
          <div style={state.is_busy ? null : {display: 'none'}}
               className="shopping-list-busy-overlay">
            <span className="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>
          </div>
        </div> );
  }
});
