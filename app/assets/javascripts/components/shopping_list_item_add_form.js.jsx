var ShoppingListItemAddForm = React.createClass({

  propTypes: {
    handleAdd: React.PropTypes.func,
    bloodhoundBuilder: React.PropTypes.func,
    create_url: React.PropTypes.string,
    price_book_pages_url: React.PropTypes.string,
    item_names_url: React.PropTypes.string,
    authenticity_token: React.PropTypes.string,
    disabled: React.PropTypes.bool
  },


  getInitialState: function () {
    return {name: "", suggestions: [],
           more_suggestions: [], bloodhound_initialized: false};
  },

  handleNameChange: function (e) {
    this.findSuggestions(e.target.value);
    this.setState({name: e.target.value});
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

  componentDidMount: function () {
    this.loadBloodhound();
  },

  loadBloodhound: function () {
    var bloodhoundBuilder = this.props.bloodhoundBuilder || window.ShoppingListItemsBloodhound;
    this.bloodhound = bloodhoundBuilder(this.props.price_book_pages_url, this.props.item_names_url);
    this.bloodhound.initialize().done(this.bloodhoundInitialized);
  },

  bloodhoundInitialized: function () {
    this.setState({bloodhound_initialized: true});
  },

  addItem: function (submit_event) {
    submit_event.preventDefault();
    this.props.handleAdd(this.state.name);
    this.setState({name: '', suggestions: [], more_suggestions: []});
  },

  addItemFromSuggestion: function (click_event) {
    click_event.preventDefault();
    var new_name = click_event.currentTarget.textContent;
    this.props.handleAdd(new_name);
    this.setState({name: '', suggestions: [], more_suggestions: []});
  },

  render: function () {
    var state = this.state;
    var props = this.props;
    var component = this;

    var suggestions = this.state.suggestions.concat(this.state.more_suggestions).slice(0,3);
    if(state.name == "") {
      suggestions = [];
    }

    suggestions.reverse();
    
    var rendered_suggestions = suggestions.map(function (name) {
      return (
          <button className="bg-info name-suggestion btn" key={"suggested-" + name}
                  onClick={component.addItemFromSuggestion} disabled={props.disabled}>
            {name}
          </button>
      );
    });

    return <div className="shopping-list-item-add-form">
      <div className="col-xs-11 shopping-list-suggestions">
        <ReactCSSTransitionGroup transitionName="shopping-list-item" transitionEnterTimeout={250}
                                 transitionLeaveTimeout={250}>
          {rendered_suggestions}
        </ReactCSSTransitionGroup>
      </div>
      <form onSubmit={this.addItem} action={props.create_url} method="post">
        <input name="authenticity_token" value={props.authenticity_token} type="hidden"/>
        <div className="col-xs-10 no-right-padding">
          <label className="sr-only" htmlFor="shopping_list_item_name">Item name</label>
          <input name="shopping_list_item[name]" className="form-control"
                 value={state.name} onChange={this.handleNameChange}
                 disabled={props.disabled} placeholder="name"
                 autoComplete={state.bloodhound_initialized ? 'off' : 'on'}
                 id="shopping_list_item_name"/>
        </div>
        <div className="col-xs-1 no-left-padding">
          <button className='btn btn-primary' disabled={props.disabled}>
            <span className="sr-only">Add</span>
            <span className="glyphicon glyphicon-plus"></span>
          </button>
        </div>
      </form>
    </div>;
  }
});
