var ShoppingListItem = React.createClass({

  propTypes: {
    page: React.PropTypes.object.isRequired,
    item: React.PropTypes.object.isRequired,
    authenticity_token: React.PropTypes.string
  },

  trim: function (str, characters) {
    return str.replace(new RegExp('^' + characters + '+|' + characters + '+$', 'g'), '');
  },

  dasherize: function (str) {
    return this.trim(str).replace(/([A-Z])/g, '-$1').replace(/[-_\s]+/g, '-').toLowerCase();
  },

  getInitialState: function () {
    return {amount: this.props.item.amount,
            unit: this.props.item.unit,
            name: this.props.item.name,
            purchased_at: this.props.item.purchased_at,
            is_busy: false,
            is_deleted: false};
  },

  componentWillReceiveProps: function (nextProps) {
    this.setState({purchased_at: nextProps.item.purchased_at});
  },

  handleAmountChange: function(e) {
    this.setState({amount: e.target.value});
  },

  handlePurchasedSubmit: function (button_event) {
    button_event.preventDefault();
    this.setState({is_busy: true});
    $.ajax({
      url: this.props.item.purchase_url,
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
      url: this.props.item.unpurchase_url,
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
    $("#confirmModal" + this.props.item.id).modal('show');
  },

  handleDelete: function (button_event) {
    button_event.preventDefault();
    $("#confirmModal" + this.props.item.id).modal('hide');
    this.setState({is_busy: true, show_form: false});
    $.ajax({
      url: this.props.item.delete_url,
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
    var category_class = 'category-' + this.dasherize(this.props.page.category);
    
    return (
        <div data-item-name={state.name}
             className="col-xs-11">
          <div className={"shopping-list-item " + category_class}>
            <span className={state.purchased_at ? 'item-name item-purchased' : 'item-name' }>
            {state.amount} {state.unit} <span data-name>{state.name}</span>
            </span>
            <span className="shopping-actions">
              <form action={props.item.purchase_url}
                    onSubmit={this.handlePurchasedSubmit}
                    style={state.purchased_at ? {display: 'none'} : null }
                    method="post" className="form-inline form-inline-block">
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
                  <span className="sr-only">purchased</span>
                  <span className="glyphicon glyphicon-shopping-cart"></span>
                </button>
              </form>
              <form action={props.item.unpurchase_url}
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
              <ConfirmDelete modal_id={"confirmModal" + props.item.id}
                             ok_handler={this.handleDelete}/>
              <form onSubmit={this.handleDeleteSubmit} action={props.item.delete_url}
                    method="post" className="form-inline form-inline-block">
                <input name="_method" value="delete" type="hidden"/>
                <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
                <button className="btn btn-link" role="button" disabled={state.is_busy || state.is_deleted}>
                  <span className="sr-only">delete</span>
                  <span className="glyphicon glyphicon-remove"></span>
                </button>
              </form>
            </span>
          </div>
        </div> );
  }
});
