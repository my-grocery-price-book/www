# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use Opal in this file: http://opalrb.org/
#
#
# Here's an example view class for your controller:
#

require 'template'

class PriceCheckView
  def initialize(parent = Element, api_service = GroceryApiService.instance)
    @api_service = api_service
    @parent = parent
    render_form
    setup
  end

  def render_form
    @parent.html = Template['price_check/search_form_and_results'].render

    @form = @parent.find('[data-price-check-control]')
    @result = @parent.find('[data-price-check-result]')

    @form.find('input').autocomplete({ source: @api_service.product_brand_names_url.to_s }.to_n)
  end

  def setup
    @form.on :submit do |event|
      event.prevent_default
      fetch_and_render_results
    end
  end

  private

  def fetch_and_render_results
    @api_service.product_summaries(@form.serialize) do |products|
      search_results_html = ''
      products.each do |product_hash|
        product = ProductPresenter.new(product_hash)
        search_results_html += Template['price_check/_search_result'].render(product)
      end
      Element['[data-autocomplete-products]'].autocomplete('close'.to_n)
      @result.html = search_results_html
    end
  end
end
