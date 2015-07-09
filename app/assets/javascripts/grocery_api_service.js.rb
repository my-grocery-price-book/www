class GroceryApiService
  attr_writer :host_url

  def self.instance(host_url = nil)
    @instance ||= GroceryApiService.new(host_url)
  end

  def initialize(host_url)
    @host_url = host_url
  end

  def store_names(&block)
    get('store_names',&block)
  end

  def location_names(&block)
    get('location_names',&block)
  end

  def product_brand_names(&block)
    get('product_brand_names',&block)
  end

  private

  def get(sub_url)
    puts "HTTP.get(\"#{@host_url}/#{sub_url}\")"
    HTTP.get("#{@host_url}/#{sub_url}") do |response|
      if response.ok?
        yield(response.json)
      else
        yield(nil)
      end
    end
  end
end

