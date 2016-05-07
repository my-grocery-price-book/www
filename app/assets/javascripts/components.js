//= require_tree ./components
const ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

function displayPrice(price) {
  if(price < 0.001) {
    return price.toExponential(3);
  } else {
    return price.toPrecision(4);
  }
}
