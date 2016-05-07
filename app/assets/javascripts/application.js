//= require react
//= require react_ujs
//= require components
//= require_self

function ShoppingListItemsBloodhound(prefetch_url, remote_url) {
  return new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    sufficient: 3,
    prefetch: {
      url: prefetch_url,
      cache: false,
      transform: function(response) {
        return response.data.map(function(value) {
          return value.name;
        });
      }
    },
    remote: {
      url: remote_url + "?query=%QUERY",
      wildcard: '%QUERY',
      transform: function(response) {
        return response.data;
      }
    }
  });
}

function displayPrice(price) {
  if(price < 0.001) {
    return price.toExponential(3);
  } else {
    return price.toPrecision(4);
  }
}
