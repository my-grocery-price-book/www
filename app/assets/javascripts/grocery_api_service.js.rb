class GroceryApiService
  def self.instance(host_url = nil)
    @instance ||= GroceryApiService.new(host_url)
  end

  def initialize(host_url, http_service = HTTP)
    @host_url = host_url
    @http_service = http_service
  end

  def store_names(&block)
    get('store_names', &block)
  end

  def location_names(&block)
    get('location_names', &block)
  end

  def product_brand_names(&block)
    get('product_brand_names', &block)
  end

  def product_brand_names_url
    "#{@host_url}/product_brand_names"
  end

  def product_summaries(query_string, &block)
    get("products?#{query_string}", &block)
  end

  private

  def get(sub_url)
    @http_service.get("#{@host_url}/#{sub_url}") do |response|
      if response.ok?
        yield(response.json)
      else
        yield(nil)
      end
    end
  end
end
