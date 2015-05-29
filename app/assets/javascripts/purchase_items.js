$(function() {
  $.getJSON( "http://za-wc.public-grocery-price-book-api.co.za/product_brand_names.json", function( data ) {
    $( "#purchase_item_product_brand_name" ).autocomplete({
        source: data
      }
    );
  });

  $.getJSON( "http://za-wc.public-grocery-price-book-api.co.za/product_generic_names.json", function( data ) {
    $( "#purchase_item_generic_name" ).autocomplete({
        source: data
      }
    );
  });
});
