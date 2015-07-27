class PriceCheckView
  class ProductPresenter
    class LastPrice
      attr_reader :value

      def initialize(info_hash)
        @value = info_hash[:price_per_package_unit]
      end
    end

    attr_reader :product, :package_unit

    def initialize(product_hash)
      @product = product_hash[:product]
      @package_unit = product_hash[:package_unit]
      @last_week = LastPrice.new(product_hash[:cheapest_last_week] || {})
      @last_month = LastPrice.new(product_hash[:cheapest_last_month] || {})
      @last_year = LastPrice.new(product_hash[:cheapest_last_year] || {})
    end

    def cheapest_last_week
      @last_week.value
    end

    def cheapest_last_month
      @last_month.value
    end

    def cheapest_last_year
      @last_year.value
    end
  end
end
