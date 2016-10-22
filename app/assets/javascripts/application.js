//= require turbolinks
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

function EntriesBloodhound(local_suggestions, remote_url) {
  return new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    sufficient: 3,
    local: local_suggestions,
    remote: {
      url: remote_url + "?query=%QUERY",
      wildcard: '%QUERY',
      transform: function(response) {
        return response.data;
      }
    }
  });
}

jQuery( document ).ready(function( $ ) {
  // Code using $ as usual goes here.
  $('#country_select_filter').on('input', function() {
    input_value = $('#country_select_filter').val().toLowerCase();
    $('[data-country-item]').each(function() {
      country_name = $( this ).text().toLowerCase();
      if(country_name.includes(input_value)) {
        $( this ).show();
      } else {
        $( this ).hide();
      }
    });
  })
});
