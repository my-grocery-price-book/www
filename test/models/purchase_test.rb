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
  let(:shopper) {create(:shopper)}

  describe '.create_for_shopper!' do
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
    it 'creates an item' do
      purchase = Purchase.create_for_shopper!(shopper)
      purchase.create_item!
      purchase.items.size.must_equal 2
    end
  end

  describe '#mark_as_completed' do
    before :each do
      @current_time = Time.current
      @purchase = create(:purchase)
    end

    def mark_as_completed(params)
      @purchase.mark_as_completed(params)
      @purchase.reload
    end

    it 'sets completed_at on purchase' do
      mark_as_completed(current_time: @current_time,
                        api_url: 'http://example.com',
                        api_key: 'a')

      @purchase.completed_at.to_s.must_equal(@current_time.to_s)
    end

    it 'exports one purchase item' do
      stub_request(:post, 'http://example.com/entries')
      create(:purchase_item, purchase_id: @purchase.id)

      mark_as_completed(current_time: @current_time,
                        api_url: 'http://example.com',
                        api_key: 'a')

      # make sure Purchases::SendItemToApiJob gets called
      assert_requested :post, 'http://example.com/entries', :times => 1
    end

    it 'exports multiple purchase item' do
      3.times { create(:purchase_item, purchase_id: @purchase.id) }
      stub_request(:post, 'http://za.example.com/entries')

      mark_as_completed(current_time: @current_time,
                        api_url: 'http://za.example.com',
                        api_key: 'a')

      # make sure Purchases::SendItemToApiJob gets called
      assert_requested :post, 'http://za.example.com/entries', :times => 3
    end
  end
end
