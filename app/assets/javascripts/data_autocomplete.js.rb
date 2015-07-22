Document.ready? do
  Element.expose :autocomplete

  if Element['[data-autocomplete-locations]'].length > 0
    GroceryApiService.instance.location_names do |location_names|
      Element['[data-autocomplete-locations]'].autocomplete({source: location_names}.to_n)
    end
  end

  if Element['[data-autocomplete-stores]'].length > 0
    GroceryApiService.instance.store_names do |store_names|
      Element['[data-autocomplete-stores]'].autocomplete({source: store_names}.to_n)
    end
  end

  if Element['[data-autocomplete-products]'].length > 0
    GroceryApiService.instance.product_brand_names do |product_brand_names|
      Element['[data-autocomplete-products]'].autocomplete({source: product_brand_names}.to_n)
    end
  end

  if Element['[data-autocomplete-price-book-pages]'].length > 0
    HTTP.get("/price_book_pages.json") do |response|
      names = response.json.map{|item| item[:name] }
      if response.ok?
        Element['[data-autocomplete-price-book-pages]'].autocomplete({source: names}.to_n)
      end
    end
  end
end
