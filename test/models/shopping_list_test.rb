# frozen_string_literal: true
# == Schema Information
#
# Table name: shopping_lists
#
#  old_id            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  title             :string
#  old_price_book_id :integer
#  price_book_id     :uuid
#  id                :uuid             not null, primary key
#

require 'test_helper'

describe ShoppingList do
  describe 'Validation' do
    it 'requires price_book_id' do
      ShoppingList.create.errors[:price_book_id].wont_be_empty
    end
  end

  describe 'to_s' do
    it 'works' do
      ShoppingList.new.to_s
    end
  end

  describe 'create_item!' do
    subject { FactoryGirl.create(:shopping_list) }

    before do
      subject.reload
      @original_time = subject.updated_at
      @new_item = subject.create_item!(name: 'Test', amount: '1', unit: 'kg')
    end

    it 'returns newly created item' do
      @new_item.must_be_kind_of(ShoppingList::Item)
      @new_item.must_be :persisted?
    end

    it 'creates a new item' do
      saved_attributes = ShoppingList::Item.last.attributes.slice('shopping_list_id', 'name', 'amount', 'unit')
      saved_attributes.must_equal('name' => 'Test', 'amount' => 1, 'unit' => 'kg', 'shopping_list_id' => subject.id)
    end

    it 'should update updated_at' do
      subject.updated_at.must_be :>, @original_time
    end
  end

  describe 'update_item!' do
    subject { FactoryGirl.create(:shopping_list) }

    before do
      subject.reload
      @original_time = subject.updated_at
      item = FactoryGirl.create(:item, shopping_list_id: subject.id)
      @updated_item = subject.update_item!(item.id, name: 'Test', amount: '1', unit: 'kg')
    end

    it 'returns updated item' do
      @updated_item.must_be_kind_of(ShoppingList::Item)
      @updated_item.must_be :persisted?
    end

    it 'updates the item' do
      saved_attributes = ShoppingList::Item.last.attributes.slice('shopping_list_id', 'name', 'amount', 'unit')
      saved_attributes.must_equal('name' => 'Test', 'amount' => 1, 'unit' => 'kg', 'shopping_list_id' => subject.id)
    end

    it 'should update updated_at' do
      subject.updated_at.must_be :>, @original_time
    end
  end

  describe 'purchase_item!' do
    subject { FactoryGirl.create(:shopping_list) }

    before do
      subject.reload
      @original_time = subject.updated_at
      item = FactoryGirl.create(:item, shopping_list_id: subject.id)
      @updated_item = subject.purchase_item!(item.id)
    end

    it 'returns updated item' do
      @updated_item.must_be_kind_of(ShoppingList::Item)
      @updated_item.purchased_at.must_be :present?
    end

    it 'should update updated_at' do
      subject.updated_at.must_be :>, @original_time
    end
  end

  describe 'unpurchase_item!' do
    subject { FactoryGirl.create(:shopping_list) }

    before do
      item = FactoryGirl.create(:item, shopping_list_id: subject.id)
      @updated_item = subject.purchase_item!(item.id)
      subject.reload
      @original_time = subject.updated_at
      @updated_item = subject.unpurchase_item!(item.id)
    end

    it 'returns updated item' do
      @updated_item.must_be_kind_of(ShoppingList::Item)
      @updated_item.purchased_at.must_be :blank?
    end

    it 'should update updated_at' do
      subject.updated_at.must_be :>, @original_time
    end
  end

  describe 'destroy_item' do
    subject { FactoryGirl.create(:shopping_list) }

    before do
      subject.reload
      @original_time = subject.updated_at
      item = FactoryGirl.create(:item, shopping_list_id: subject.id)
      @item = subject.destroy_item(item.id)
    end

    it 'returns destroyed item' do
      @item.must_be_kind_of(ShoppingList::Item)
    end

    it 'destroys item' do
      assert_raises ActiveRecord::RecordNotFound do
        @item.reload
      end
    end

    it 'should update updated_at' do
      subject.updated_at.must_be :>, @original_time
    end
  end

  describe '.item_names_for_book' do
    before do
      @book = PriceBook.create!
      @shopping_list = @book.create_shopping_list!
    end

    it 'returns all item names' do
      @shopping_list.create_item!(name: 'Cheese')
      names = ShoppingList.item_names_for_book(@book, query: nil)
      assert_equal(['Cheese'], names)
    end

    it 'returns them in alphabetical order' do
      @shopping_list.create_item!(name: 'Cheese')
      @shopping_list.create_item!(name: 'Meat')
      @shopping_list.create_item!(name: 'Apples')
      names = ShoppingList.item_names_for_book(@book, query: nil)
      assert_equal(%w(Apples Cheese Meat), names)
    end

    it 'returns items filtered' do
      @shopping_list.create_item!(name: 'Cheese')
      @shopping_list.create_item!(name: 'Meat')
      @shopping_list.create_item!(name: 'Apples')
      names = ShoppingList.item_names_for_book(@book, query: 's')
      assert_equal(%w(Apples Cheese), names)
    end

    it 'ignores duplicates' do
      @shopping_list.create_item!(name: 'Cheese')
      @shopping_list.create_item!(name: 'Cheese')
      names = ShoppingList.item_names_for_book(@book, query: nil)
      assert_equal(['Cheese'], names)
    end

    it 'ignores case duplicates' do
      @shopping_list.create_item!(name: 'Cheese')
      @shopping_list.create_item!(name: 'cheese')
      @shopping_list.create_item!(name: 'apples')
      @shopping_list.create_item!(name: 'appleS')
      names = ShoppingList.item_names_for_book(@book, query: nil)
      assert_equal(%w(apples cheese), names)
    end

    it 'ignores items of other books' do
      other_book = PriceBook.create!
      other_shopping_list = other_book.create_shopping_list!

      other_shopping_list.create_item!(name: 'Bread')

      names = ShoppingList.item_names_for_book(@book, query: nil)
      assert_equal([], names)
    end

    it 'limits to ten results' do
      results = ('a'..'z')
      results.each do |r|
        @shopping_list.create_item!(name: r)
      end
      ('A'..'Z').each do |r|
        @shopping_list.create_item!(name: r)
      end

      names = ShoppingList.item_names_for_book(@book, query: nil)
      assert_equal(results.first(10), names)
    end

    it 'ignores items older than 6 months' do
      @shopping_list.create_item!(name: 'Butter', created_at: 6.months.ago - 1.day)
      @shopping_list.create_item!(name: 'Bread', created_at: 6.months.ago + 1.day)

      names = ShoppingList.item_names_for_book(@book, query: nil)
      assert_equal(['Bread'], names)
    end
  end
end
