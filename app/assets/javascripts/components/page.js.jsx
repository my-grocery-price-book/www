var Page = React.createClass({

  propTypes: {
    show_url: React.PropTypes.string,
    edit_url: React.PropTypes.string,
    delete_url: React.PropTypes.string,
    page_id: React.PropTypes.number,
    name: React.PropTypes.string,
    category: React.PropTypes.string,
    unit: React.PropTypes.string,
    authenticity_token: React.PropTypes.string
  },

  render: function () {
    var props = this.props;
    // var state = this.state;

    return (
        <div className="col-xs-6 col-sm-4 col-md-2">
          <div className="thumbnail">
            <div className="caption">
              <h4>
                <a href={ props.show_url }>
                  { props.name }
                </a>
              </h4>
              <p>{ props.category },{ props.unit }</p>
              <div className="btn-group" role="group">
                <a href={ props.edit_url }
                   className="btn btn-primary" aria-label="Edit"
                   role="button">
                  <i className="glyphicon glyphicon-edit"></i>
                </a>
                <a href={ props.delete_url }
                   className="btn btn-default" aria-label="Delete"
                   role="button">
                  <i className="glyphicon glyphicon-trash"></i>
                </a>
              </div>
            </div>
          </div>
        </div> );
  }
});
