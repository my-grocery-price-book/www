# frozen_string_literal: true

module EntriesHelper
  def stores_options_for_book(book)
    book.stores.map do |store|
      [store.name_and_location, store.id.to_s]
    end
  end
end
