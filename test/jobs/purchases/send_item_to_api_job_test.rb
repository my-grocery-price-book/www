require 'test_helper'

describe Purchases::SendItemToApiJob do
  subject {Purchases::SendItemToApiJob}

  def perform_now(options = {})
    options.reverse_merge!(api_url: 'http://za-wc.example.com/',
                           api_key: 'my_key',
                           date_on: Date.current,
                           store: 'Woolworths',
                           location: 'CanalWalk',
                           item: PurchaseItem.new)

    stub_request(:post, 'http://za-wc.example.com/entries')

    subject.perform_now(options)
  end

  it 'performs post with product_brand_name' do
    p = PurchaseItem.new(product_brand_name: 'Coke Lite')

    perform_now(item: p)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('product_brand_name=Coke+Lite') }
  end

  it 'performs post with generic_name' do
    p = PurchaseItem.new(regular_name: 'Soda')

    perform_now(item: p)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('generic_name=Soda') }
  end

  it 'performs post with category' do
    p = PurchaseItem.new(category: 'Drinks')

    perform_now(item: p)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('category=Drinks') }
  end

  it 'performs post with package_size' do
    p = PurchaseItem.new(package_size: 340)

    perform_now(item: p)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('package_size=340') }
  end

  it 'performs post with package_size' do
    p = PurchaseItem.new(package_unit: 'ml')

    perform_now(item: p)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('package_unit=ml') }
  end

  it 'performs post with quantity' do
    p = PurchaseItem.new(quantity: 1)

    perform_now(item: p)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('quantity=1') }
  end

  it 'performs post with total_price' do
    p = PurchaseItem.new(total_price: 15.55)

    perform_now(item: p)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('total_price=15.55') }
  end

  it 'performs post with date_on' do
    perform_now(date_on: Date.current)

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?("date_on=#{Date.current}") }
  end

  it 'performs post with store' do
    perform_now(store: 'OK')

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('store=OK') }
  end

  it 'performs post with location' do
    perform_now(location: 'Goodwood')

    assert_requested(:post, 'http://za-wc.example.com/entries',
                     :times => 1) { |req| req.body.include?('location=Goodwood') }
  end
end
