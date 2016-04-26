module EntriesHelper
  def stores_options_for_book(book)
    book.stores.map{|s| [s.name_and_location, s.id.to_s]}
  end
end
