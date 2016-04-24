require 'yaml'
require 'carmen'

Region = Struct.new(:code, :region_name, :country_name)
class Region
  def self.find_by_code(code)
    all.find { |region| region.code == code }
  end

  def self.first_code
    all.first.code
  end

  def self.all
    all = []
    ['South Africa', 'United States', 'United Kingdom', 'Australia'].each do |country_name|
      country = Carmen::Country.named(country_name)
      country.subregions.each do |region|
        code = "#{country.alpha_2_code}-#{region.code}"
        all << new(code, region.name, country.name)
      end
    end
    all
  end

  def name
    "#{country_name} - #{region_name}"
  end
end
