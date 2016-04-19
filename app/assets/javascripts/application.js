//= require react
//= require react_ujs
//= require components
//= require_self

function ShoppingListItemsBloodhound(url) {
  return new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    sufficient: 3,
    prefetch: {
      url: url,
      cache: false,
      transform: function(response) {
        return response.data.map(function(value) {
          return value.name;
        });
      }
    }
  });
}
