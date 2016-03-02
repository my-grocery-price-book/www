var ShoppingListIndex = React.createClass({

  propTypes: {
    initialLists: React.PropTypes.arrayOf(React.PropTypes.object),
    createUrl: React.PropTypes.string,
    authenticityToken: React.PropTypes.string
  },

  getInitialState: function () {
    return {lists: this.props.initialLists};
  },

  createShoppingList: function (submit_event) {
    submit_event.preventDefault();
    this.setState({is_busy_creating: true});
    $.ajax({
      url: this.props.createUrl,
      dataType: 'json',
      type: 'POST',
      data: {"authenticity_token": this.props.authenticityToken},
      success: function (response) {
        var newArray = this.state.lists.slice();
        newArray.unshift(response.data);
        this.setState({lists: newArray, is_busy_creating: false});
      }.bind(this),
      error: function (xhr, status, err) {
        this.setState({is_busy_creating: false});
        console.error(status, err.toString());
      }.bind(this)
    });
  },

  render: function () {
    var vm = this;
    var render_lists = this.state.lists.map(function (list) {
      return (
          <ShoppingList key={"list_" + list.id}
                        update_url={list.update_url}
                        delete_url={list.delete_url}
                        items_url={list.items_url}
                        item_id={list.id}
                        title={list.title}
                        item_progress={list.item_progress}
                        authenticityToken={vm.props.authenticityToken}/>
      );
    });

    return <div>
      <div className="row">
        <div className="col-md-12">
          <h1>Shopping Lists</h1>
          <form action={this.props.createUrl} method="post" onSubmit={this.createShoppingList}>
            <input name="authenticity_token" value={this.props.authenticityToken} type="hidden"/>
            <button className='btn btn-default'>New Shopping List</button>
          </form>
          { this.state.is_busy_creating ? <span className="glyphicon glyphicon-refresh glyphicon-refresh-animate"
                                                aria-hidden="true"></span> : null }
        </div>
      </div>
      <div className="row">
        {render_lists}
      </div>
    </div>;
  }
});
