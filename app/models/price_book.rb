# == Schema Information
#
# Table name: price_books
#
#  id                              :integer          not null, primary key
#  _deprecated_shopper_id          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  name                            :string           default("My Price Book"), not null
#  _deprecated_shopper_id_migrated :boolean          default(FALSE), not null
#

class PriceBook < ActiveRecord::Base
  validates :name, presence: true
  has_many :pages, dependent: :delete_all
  has_many :members, dependent: :delete_all

  attr_writer :shopper
  after_create :create_member

  def create_member
    members.create!(shopper: @shopper)
  end

  def self.for_shopper(shopper)
    book = joins(:members).find_by(members: { shopper_id: shopper.id })
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
    pages.where('name ILIKE ?', "%#{term}%").order('id DESC')
  end

  def find_page!(page_id)
    pages.where("CONCAT(LOWER(category),'_',LOWER(unit),'_',LOWER(name)) = ?", page_id).first!
  end

  def to_s
    "<PriceBook id:#{id} name:#{name} member_count:#{members.count} />"
  end
end
