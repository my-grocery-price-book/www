module BookHelper
  def book_region_options
    [''] + RegionFinder.instance.map { |r| [r.name, r.code] }
  end
end
