var Page = React.createClass({

  propTypes: {
    page: React.PropTypes.object,
    authenticity_token: React.PropTypes.string
  },

  render: function () {
    var page = this.props.page;
    var info = <div className="page-info">
      { page.category },{ page.unit }
    </div>;

    if(page.best_entry) {
      var best_entry = page.best_entry;
      var ratio = window.displayPrice(best_entry.total_price / (best_entry.amount * best_entry.package_size));
      info = <div className="page-info">
        <div className="page-best-price-ratio">{ratio} / {best_entry.package_unit}</div>
        <div className="page-best-product-name">{best_entry.product_name}</div>
        <div className="page-best-store">{best_entry.store_name} {best_entry.location}</div>
        <div className="page-best-price">{best_entry.total_price} for {best_entry.amount} x {best_entry.package_size} {best_entry.package_unit}</div>
      </div>;
    }

    return (
        <div className="col-xs-12 col-sm-6 col-md-4">
          <div className="thumbnail">
            <h4>
              <a href={ page.show_url }>{ page.name }</a>
            </h4>
            { info }
          </div>
        </div> );
  }
});
