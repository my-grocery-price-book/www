require 'carmen'

class RegionFinder
  include Singleton
  include Enumerable

  class Region
    attr_reader :code, :region_name, :country_name

    def initialize(code, region_name, country_name)
      @code = code.freeze
      @region_name = region_name.freeze
      @country_name = country_name.freeze
    end

    def name
      "#{country_name} - #{region_name}"
    end
  end

  def initialize
    @all = []
    Carmen::World.instance.subregions.each do |country|
      country.subregions.each do |region|
        code = "#{country.alpha_3_code}-#{region.code}"
        @all << Region.new(code, region.name, country.name)
      end
    end
    @all.sort_by!(&:name)
  end

  def each
    @all.each do |item|
      yield(item)
    end
  end

  def find_by_code(code)
    @all.find { |region| region.code == code }
  end

  def first_code
    @all.first.code
  end

  def size
    @all.size
  end
end
