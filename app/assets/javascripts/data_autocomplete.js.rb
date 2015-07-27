Document.ready? do
  if Element['[data-autocomplete-locations]'].any?
    GroceryApiService.instance.location_names do |location_names|
      Element['[data-autocomplete-locations]'].autocomplete({source: location_names}.to_n)
    end
  end

  if Element['[data-autocomplete-stores]'].any?
    GroceryApiService.instance.store_names do |store_names|
      Element['[data-autocomplete-stores]'].autocomplete({source: store_names}.to_n)
    end
  end

  if Element['[data-autocomplete-products]'].any?
    Element['[data-autocomplete-products]'].autocomplete({source: "#{GroceryApiService.instance.product_brand_names_url}"}.to_n)
  end

  if Element['[data-autocomplete-price-book-pages]'].any?
    HTTP.get("/price_book_pages.json") do |response|
      names = response.json.map{|item| item[:name] }
      if response.ok?
        Element['[data-autocomplete-price-book-pages]'].autocomplete({source: names}.to_n)
      end
    end
  end
end
