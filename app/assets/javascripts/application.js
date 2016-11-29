//= require webpack-bundle
//= require turbolinks
//= require_self

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
