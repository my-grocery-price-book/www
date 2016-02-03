# == Schema Information
#
# Table name: price_books
#
#  id         :integer          not null, primary key
#  shopper_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PriceBook < ActiveRecord::Base
  validates :shopper_id, uniqueness: true, presence: true
  has_many :pages, dependent: :delete_all
  belongs_to :shopper

  def self.for_shopper(shopper)
    book = find_by(shopper_id: shopper.id)
    return book if book
    new(shopper: shopper).tap do |new_book|
      new_book.extend(ForShopperDefaultPages)
      new_book.build_default_pages
      new_book.save
    end
  end

  # used and tested through Pricebook#for_shopper
  module ForShopperDefaultPages
    def build_default_pages
      build_default_fresh_pages
      build_bakery_pages
      build_food_cupboard_pages
      build_drinks_pages
    end

    private

    def build_food_cupboard_pages
      pages.new(name: 'Flour', category: 'Food Cupboard', unit: 'grams')
      pages.new(name: 'Maize', category: 'Food Cupboard', unit: 'grams')
      pages.new(name: 'Rice', category: 'Food Cupboard', unit: 'grams')
      pages.new(name: 'Sugar', category: 'Food Cupboard', unit: 'grams')
    end

    def build_drinks_pages
      pages.new(name: 'Soda', category: 'Drinks', unit: 'milliliters')
      pages.new(name: 'Tea', category: 'Drinks', unit: 'bags')
      pages.new(name: 'Coffee', category: 'Drinks', unit: 'grams')
    end

    def build_bakery_pages
      pages.new(name: 'Bread', category: 'Bakery', unit: 'grams')
    end

    def build_default_fresh_pages
      [%w(Apples grams), %w(Cabbage cabbages), %w(Cheese grams), %w(Eggs dozens),
       %w(Milk milliliters), %w(Margarine grams), %w(Mince grams),
       %w(Chicken grams)].each do |name, unit|
        pages.new(name: name, category: 'Fresh', unit: unit)
      end
    end
  end

  def page_count
    pages.count
  end

  def update_product!(info)
    item = pages.find_or_initialize_by(
      category: info[:category],
      name: info[:regular_name],
      unit: info[:package_unit]
    )
    item.product_names << info[:product_brand_name]
    item.save
  end

  def search_pages(term)
    pages.where('name ILIKE ?', "%#{term}%")
  end

  def find_page!(page_id)
    pages.where("CONCAT(LOWER(category),'_',LOWER(unit),'_',LOWER(name)) = ?", page_id).first!
  end
end