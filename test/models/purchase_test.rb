# == Schema Information
#
# Table name: purchases
#
#  id           :integer          not null, primary key
#  purchased_on :date
#  store        :string
#  location     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  shopper_id   :integer
#  completed_at :datetime
#

require 'test_helper'

describe Purchase do
  describe '.create_for_shopper!' do
    let(:shopper) { create_shopper }

    it 'creates a purchase and item' do
      Purchase.create_for_shopper!(shopper)
      purchase = Purchase.for_shopper(shopper).first
      purchase.items.size.must_equal 1
    end

    it 'set purchased_on to Date.current' do
      purchase = Purchase.create_for_shopper!(shopper)
      purchase.purchased_on.must_equal Date.current
    end
  end

  describe '#create_item!' do
    let(:shopper) { create_shopper }

    it 'creates an item' do
      purchase = Purchase.create_for_shopper!(shopper)
      purchase.create_item!
      purchase.items.size.must_equal 2
    end
  end

  describe '#mark_as_completed' do
    before :each do
      @current_time = Time.current
      @purchase = Purchase.create!(shopper_id: 11, purchased_on: Time.zone.today)
    end

    def mark_as_completed(params)
      @purchase.mark_as_completed(params)
      @purchase.reload
    end

    it 'sets completed_at on purchase' do
      mark_as_completed(current_time: @current_time,
                        api_root: 'http://example.com',
                        api_region_code: 'za-wc',
                        api_key: 'a')

      @purchase.completed_at.to_s.must_equal(@current_time.to_s)
    end

    it 'exports one purchase item' do
      stub_request(:post, 'http://example.com/za-wc/entries')
      @purchase.items.create!

      mark_as_completed(current_time: @current_time,
                        api_root: 'http://example.com',
                        api_region_code: 'za-wc',
                        api_key: 'a')

      # make sure Purchases::SendItemToApiJob gets called
      assert_requested :post, 'http://example.com/za-wc/entries', times: 1
    end

    it 'exports multiple purchase item' do
      3.times { @purchase.items.create! }
      stub_request(:post, 'http://example.com/za-wc/entries')

      mark_as_completed(current_time: @current_time, api_root: 'http://example.com',
                        api_region_code: 'za-wc', api_key: 'a')

      # make sure Purchases::SendItemToApiJob gets called
      assert_requested :post, 'http://example.com/za-wc/entries', times: 3
    end
  end

  describe 'Validation' do
    it 'must have a shopper' do
      purchase = Purchase.new
      purchase.valid?
      purchase.errors[:shopper_id].wont_be_empty
    end

    it 'must have a purchase date' do
      purchase = Purchase.new
      purchase.valid?
      purchase.errors[:purchased_on].wont_be_empty
    end
  end
end
