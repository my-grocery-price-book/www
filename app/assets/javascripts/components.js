//= require_tree ./components
const ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

function displayPrice(price) {
  if(price < 0.001) {
    return price.toExponential(3);
  } else {
    return price.toPrecision(4);
  }
}

function displayPriceRatio(p, unit) {
  if(unit == 'grams' && p >= 1000) {
    return (displayPrice(p / 1000) + ' / kilograms');
  } else if(unit == 'kilograms' && p <= 0.01) {
    return (displayPrice(p * 1000) + ' / grams');
  } else if(unit == 'milliliters' && p >= 1000) {
    return (displayPrice(p / 1000) + ' / liters');
  } else if(unit == 'liters' && p <= 0.01) {
    return (displayPrice(p * 1000) + ' / milliliters');
  } else {
    return (displayPrice(p) + ' / ' + unit);
  }

}
