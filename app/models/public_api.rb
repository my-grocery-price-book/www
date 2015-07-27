require 'yaml'

class PublicApi < Struct.new(:code, :name, :domain)
  def url
    "http://#{domain}"
  end

  def self.find_by_code(code)
    all.find{|api| api.code == code}
  end

  def self.first_code
    all.first.code
  end

  def self.all
    @@all
  end

  def self.load(config_filename = File.join(Rails.root,'config/public_apis.yml'))
    @@all = YAML.load_file(config_filename).map do |api_info|
      new(api_info['code'],api_info['name'],api_info['domain'])
    end
  end
end

PublicApi.load
