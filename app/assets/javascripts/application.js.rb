require 'opal'
require 'opal-jquery'
require_tree '.'

Element.expose :autocomplete

Document.ready? do
  if Element['[data-price-check]'].any?
    PriceCheckView.new(Element['[data-price-check]']);
  end
end
