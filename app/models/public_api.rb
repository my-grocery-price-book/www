require 'yaml'
require 'carmen'

PublicApi = Struct.new(:code, :name, :url_root, :country_name)
class PublicApi
  def url
    "#{url_root}/#{code}"
  end

  def self.find_by_code(code)
    all.find { |api| api.code == code }
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
        all << new(code, "#{country.name} - #{region.name}", ENV['PUBLIC_API_DOMAIN'], country.name)
      end
    end
    all
  end
end
