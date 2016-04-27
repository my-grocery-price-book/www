# == Schema Information
#
# Table name: stores
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  location    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_code :string           not null
#

require 'test_helper'

describe Store do
  describe 'Validation' do
    it 'requires name' do
      Store.create.errors[:name].wont_be_empty
    end

    it 'requires price_book_id' do
      Store.create.errors[:location].wont_be_empty
    end

    it 'requires region' do
      Store.create.errors[:region_code].wont_be_empty
    end
  end

  describe 'save' do
    it 'strips leading spacing' do
      store = Store.create!(name: ' World', location: ' Space', region_code: 'ZAR-WC')
      store.reload
      assert_equal(store.attributes.slice('name', 'location'),
                   'name' => 'World', 'location' => 'Space')
    end

    it 'strips trailing spacing' do
      store = Store.create!(name: 'World ', location: 'Space ', region_code: 'ZAR-WC')
      store.reload
      assert_equal(store.attributes.slice('name', 'location'),
                   'name' => 'World', 'location' => 'Space')
    end
  end

  describe 'find_or_initialize' do
    it 'builds a new when no match' do
      store = Store.find_or_initialize(name: 'World',
                                       location: 'Space',
                                       region_code: 'ZAR-WC')
      assert store.new_record?
      assert_equal({ 'name' => 'World', 'location' => 'Space', 'region_code' => 'ZAR-WC' },
                   store.attributes.slice('name', 'location', 'region_code'))
    end

    it 'matches on correct name and location' do
      Store.create!(name: 'Hello', location: 'Mars', region_code: 'ZAR-WC')
      Store.create!(name: 'Hello', location: 'Earth', region_code: 'ZAR-WC')
      store = Store.find_or_initialize(name: 'Hello',
                                       location: 'Earth',
                                       region_code: 'ZAR-WC')
      assert store.persisted?
      assert_equal({ 'name' => 'Hello', 'location' => 'Earth', 'region_code' => 'ZAR-WC' },
                   store.attributes.slice('name', 'location', 'region_code'))
    end

    it 'matches case insensitvity' do
      Store.create!(name: 'hello', location: 'world', region_code: 'ZAR-WC')
      store = Store.find_or_initialize(name: 'Hello',
                                       location: 'World',
                                       region_code: 'ZAR-WC')
      assert store.persisted?
      assert_equal({ 'name' => 'hello', 'location' => 'world', 'region_code' => 'ZAR-WC' },
                   store.attributes.slice('name', 'location', 'region_code'))
    end

    it 'matches ignoring leading and trailing spacing' do
      Store.create!(name: 'place here', location: 'go there', region_code: 'ZAR-WC')
      store = Store.find_or_initialize(name: ' place here ',
                                       location: ' go there ',
                                       region_code: 'ZAR-WC')
      assert store.persisted?
      assert_equal({ 'name' => 'place here', 'location' => 'go there', 'region_code' => 'ZAR-WC' },
                   store.attributes.slice('name', 'location', 'region_code'))
    end

    it 'matches ignoring spacing' do
      Store.create!(name: 'place here', location: 'gothere', region_code: 'ZAR-WC')
      store = Store.find_or_initialize(name: ' placehere ',
                                       location: ' go there ',
                                       region_code: 'ZAR-WC')
      assert store.persisted?
      assert_equal({ 'name' => 'place here', 'location' => 'gothere', 'region_code' => 'ZAR-WC' },
                   store.attributes.slice('name', 'location', 'region_code'))
    end

    it 'matches ignoring spacing' do
      Store.create!(name: 'placehere', location: 'go there', region_code: 'ZAR-WC')
      store = Store.find_or_initialize(name: ' place here ',
                                       location: ' gothere ',
                                       region_code: 'ZAR-WC')
      assert store.persisted?
      assert_equal({ 'name' => 'placehere', 'location' => 'go there', 'region_code' => 'ZAR-WC' },
                   store.attributes.slice('name', 'location', 'region_code'))
    end

    it 'matches in correct region_code' do
      Store.create!(name: 'hello', location: 'world', region_code: 'ZAR-EC')
      Store.create!(name: 'hello', location: 'world', region_code: 'ZAR-WC')
      Store.create!(name: 'hello', location: 'world', region_code: 'ZAR-NW')
      store = Store.find_or_initialize(name: 'hello',
                                       location: 'world',
                                       region_code: 'ZAR-WC')
      assert store.persisted?
      assert_equal({ 'name' => 'hello', 'location' => 'world', 'region_code' => 'ZAR-WC' },
                   store.attributes.slice('name', 'location', 'region_code'))
    end
  end
end
