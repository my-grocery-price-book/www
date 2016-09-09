# frozen_string_literal: true
module BookHelper
  def book_region_options(regions)
    regions.map do |region|
      [region.region_name, region.code]
    end
  end
end
