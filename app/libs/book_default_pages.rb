# frozen_string_literal: true

class BookDefaultPages
  # @param [PriceBook] book
  def initialize(book)
    @book = book
  end

  def create_pages
    create_default_fresh_pages
    create_bakery_pages
    create_food_cupboard_pages
    create_drinks_pages
  end

  private

  def create_food_cupboard_pages
    PriceBook::Page.create(book: @book, name: 'Flour', category: 'Food Cupboard', unit: 'grams')
    PriceBook::Page.create(book: @book, name: 'Maize', category: 'Food Cupboard', unit: 'grams')
    PriceBook::Page.create(book: @book, name: 'Rice', category: 'Food Cupboard', unit: 'grams')
    PriceBook::Page.create(book: @book, name: 'Sugar', category: 'Food Cupboard', unit: 'grams')
  end

  def create_drinks_pages
    PriceBook::Page.create(book: @book, name: 'Soda', category: 'Drinks', unit: 'milliliters')
    PriceBook::Page.create(book: @book, name: 'Tea', category: 'Drinks', unit: 'bags')
    PriceBook::Page.create(book: @book, name: 'Coffee', category: 'Drinks', unit: 'grams')
  end

  def create_bakery_pages
    PriceBook::Page.create(book: @book, name: 'Bread', category: 'Bakery', unit: 'grams')
  end

  def create_default_fresh_pages
    [%w[Apples grams], %w[Cabbage cabbages], %w[Cheese grams], %w[Eggs dozens],
     %w[Milk milliliters], %w[Margarine grams], %w[Mince grams],
     %w[Chicken grams]].each do |name, unit|
      PriceBook::Page.create(book: @book, name: name, category: 'Fresh', unit: unit)
    end
  end
end
