module BookHelper
  def book_region_options(regions)
    regions.map do |r|
      [r.region_name, r.code]
    end
  end
end
