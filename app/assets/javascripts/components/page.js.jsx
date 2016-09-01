var Page = React.createClass({

  trim: function (str, characters) {
    return str.replace(new RegExp('^' + characters + '+|' + characters + '+$', 'g'), '');
  },

  dasherize: function (str) {
    return this.trim(str).replace(/([A-Z])/g, '-$1').replace(/[-_\s]+/g, '-').toLowerCase();
  },

  propTypes: {
    page: React.PropTypes.object,
    visible: React.PropTypes.bool,
    authenticity_token: React.PropTypes.string
  },

  render: function () {
    var page = this.props.page;

    var info = <div className="page-info">
      { page.category },{ page.unit }
    </div>;

    if(page.best_entry) {
      var best_entry = page.best_entry;
      var ratio = window.displayPriceRatio(best_entry.price_per_unit, best_entry.package_unit);
      info = <div className="page-info">
        <div className="page-best-price-ratio">{best_entry.currency_symbol} {ratio}</div>
        <div className="page-best-product-name">{best_entry.product_name}</div>
        <div className="page-best-store">{best_entry.store_name} {best_entry.location}</div>
        <div className="page-best-price">{best_entry.currency_symbol} {best_entry.total_price} for {best_entry.amount} x {best_entry.package_size} {best_entry.package_unit}</div>
      </div>;
    }

    return (
        <div className="col-xs-12 col-sm-6 col-md-4"
             data-page-name={page.name}
             style={this.props.visible ? null : {display: 'none'}}>
          <div className={"thumbnail category-" + this.dasherize(page.category || 'other')}>
            <h4>
              <a href={ page.show_url }>{ page.name }</a>
              <a className="btn btn-add-entry" href={page.add_entry_url}>
                <i className="glyphicon glyphicon-plus"></i>
              </a>
            </h4>
            { info }
          </div>
        </div> );
  }
});
