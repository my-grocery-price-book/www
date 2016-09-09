# frozen_string_literal: true
require 'carmen'
require 'countries'

class RegionFinder
  include Singleton
  include Enumerable

  class Region
    def initialize(country, region)
      @country = country
      @region = region
      @currency = ISO3166::Country.find_country_by_alpha3(@country.alpha_3_code).currency
    end

    def name
      "#{country_name} - #{region_name}"
    end

    def country_name
      @country.name
    end

    def alpha_3_code
      @country.alpha_3_code
    end

    def region_name
      @region.name
    end

    def code
      "#{@country.alpha_3_code}-#{@region.code}"
    end

    def currency_symbol
      @currency.symbol
    end
  end

  def self.countries
    Carmen::World.instance.subregions.sort_by(&:name)
  end

  def initialize
    @all = Carmen::World.instance.subregions.flat_map do |country|
      country.subregions.map { |region| Region.new(country, region) }
    end
    @all.sort_by!(&:name)
  end

  def each
    @all.each do |item|
      yield(item)
    end
  end

  def for_alpha_3_code(alpha_3_code)
    select { |region| region.alpha_3_code == alpha_3_code }
  end

  # @param [String] code
  # @return [RegionFinder::Region]
  def find_by_code(code)
    find { |region| region.code == code }
  end

  # @param [Array<String>] codes
  # @return [Array<RegionFinder::Region>]
  def find_by_codes(codes)
    select { |region| codes.include?(region.code) }
  end

  def first_code
    first.code
  end

  def size
    to_a.size
  end
end
