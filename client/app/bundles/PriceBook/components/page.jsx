import React, {PropTypes} from 'react';

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

  displayPrice: function (price) {
    if (price < 0.001) {
      return price.toExponential(3);
    } else {
      return price.toPrecision(4);
    }
  },

  displayPriceRatio: function (p, unit) {
    if (unit == 'grams' && p >= 1000) {
      return (this.displayPrice(p / 1000) + ' / kilograms');
    } else if (unit == 'kilograms' && p <= 0.01) {
      return (this.displayPrice(p * 1000) + ' / grams');
    } else if (unit == 'milliliters' && p >= 1000) {
      return (this.displayPrice(p / 1000) + ' / liters');
    } else if (unit == 'liters' && p <= 0.01) {
      return (this.displayPrice(p * 1000) + ' / milliliters');
    } else {
      return (this.displayPrice(p) + ' / ' + unit);
    }
  },

  render: function () {
    var page = this.props.page;

    var info = <div className="page-info">
      { page.category },{ page.unit }
    </div>;

    if (page.best_entry) {
      var best_entry = page.best_entry;
      var ratio = this.displayPriceRatio(best_entry.price_per_unit, best_entry.package_unit);
      info = <div className="page-info">
        <div className="page-best-price-ratio">{best_entry.currency_symbol} {ratio}</div>
        <div className="page-best-product-name">{best_entry.product_name}</div>
        <div className="page-best-store">{best_entry.store_name} {best_entry.location}</div>
        <div className="page-best-price">{best_entry.currency_symbol} {best_entry.total_price} for {best_entry.amount}
          x {best_entry.package_size} {best_entry.package_unit}</div>
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

export default Page;
