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
#  region_codes                    :string           default([]), is an Array
#  store_ids                       :integer          default([]), is an Array
#

class PriceBook < ActiveRecord::Base
  validates :name, presence: true
  has_many :pages, dependent: :delete_all
  has_many :members, dependent: :delete_all
  has_many :shopping_lists, dependent: :destroy

  attr_writer :shopper
  after_create :create_member

  before_save :set__deprecated_shopper_id_migrated

  def stores
    Store.where(id: store_ids)
  end

  # @param [Store] store
  def add_store!(store)
    store_ids << store.id
    save!
  end

  def create_shopping_list!(*a)
    shopping_lists.create(*a)
  end

  def set__deprecated_shopper_id_migrated
    self._deprecated_shopper_id_migrated = true
  end

  def create_member
    members.create!(shopper: @shopper) if @shopper
  end

  # @param [Shopper] shopper
  def add_member(shopper)
    members.create(shopper: shopper)
  end

  def self.default_for_shopper(shopper)
    book = for_shopper(shopper).order('price_books.id DESC').first
    return book if book
    new(shopper: shopper).tap do |new_book|
      new_book.extend(ForShopperDefaultPages)
      new_book.build_default_pages
      new_book.save
    end
  end

  # @param [Shopper] shopper
  # @param [String] id
  # @return [PriceBook]
  def self.find_for_shopper(shopper, id)
    for_shopper(shopper).find(id)
  end

  # @param [Shopper] shopper
  # @return [Array<PriceBook>]
  def self.for_shopper(shopper)
    joins(:members).where(members: { shopper_id: shopper.id })
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

  def search_pages(term)
    pages.where('name ILIKE ?', "%#{term}%").order('id DESC')
  end

  def find_page!(page_id)
    pages.find(page_id)
  end

  def region_set?
    region_codes.select(&:present?).any?
  end

  def to_s
    "<PriceBook id:#{id} name:#{name} member_count:#{members.count} />"
  end
end
