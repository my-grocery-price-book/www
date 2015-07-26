require 'spec_helper'
require 'price_check_view'
require 'price_check/product_presenter'
require 'templates/price_check/search_form_and_results'
require 'templates/price_check/_search_result'

describe PriceCheckView do
  let(:http_mock) {HTTPMock.new}
  let(:main_element) {Element.new('div')}

  it 'renders' do
    http_mock.set_ok_response('/products?term=',
      [
        {
          product: 'Eggs',
          package_unit: 'Eggs',
          cheapest_last_week: {price_per_package_unit: 0.11},
          cheapest_last_month: {price_per_package_unit: 0.12},
          cheapest_last_year: {price_per_package_unit: 0.13}
        }
      ]
    )
    Element['body'].append(main_element)

    PriceCheckView.new(main_element, GroceryApiService.new('',http_mock))

    Element['form'].trigger('submit')

    result = Element['[data-price-check-result]'].to_s
    expect(result).to include("<tbody data-price-check-result=\"\"><tr>\n  <td>Eggs (Eggs)</td>\n  <td>0.11</td>\n  <td>0.12</td>\n  <td>0.13</td>\n</tr>\n</tbody>")
  end
end

describe PriceCheckView::ProductPresenter do
  subject {PriceCheckView::ProductPresenter}

  describe 'product' do
    it 'returns product' do
      presenter = subject.new(product: 'hello')
      expect(presenter.product).to eq('hello')
    end
  end

  describe 'package_unit' do
    it 'returns package_unit' do
      presenter = subject.new(package_unit: 'test')
      expect(presenter.package_unit).to eq('test')
    end
  end

  describe 'cheapest_last_week' do
    it 'returns cheapest_last_week price_per_package_unit' do
      presenter = subject.new(
        cheapest_last_week: { price_per_package_unit: '0.11' }
      )
      expect(presenter.cheapest_last_week).to eq('0.11')
    end
  end

  describe 'cheapest_last_month' do
    it 'returns cheapest_last_month price_per_package_unit' do
      presenter = subject.new(
        cheapest_last_month: { price_per_package_unit: '0.22' }
      )
      expect(presenter.cheapest_last_month).to eq('0.22')
    end
  end

  describe 'cheapest_last_year' do
    it 'returns cheapest_last_year price_per_package_unit' do
      presenter = subject.new(
        cheapest_last_year: { price_per_package_unit: '0.33' }
      )
      expect(presenter.cheapest_last_year).to eq('0.33')
    end
  end
end
