$(function() {
  $.getJSON( "http://za-wc.public-grocery-price-book-api.co.za/location_names.json", function( data ) {
    $( "#purchase_location" ).autocomplete({
        source: data
      }
    );
  });

  $.getJSON( "http://za-wc.public-grocery-price-book-api.co.za/store_names.json", function( data ) {
    $( "#purchase_store" ).autocomplete({
        source: data
      }
    );
  });
});
