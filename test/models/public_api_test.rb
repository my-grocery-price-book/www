require 'test_helper'

describe PublicApi do
  describe 'first_code' do
    it 'gives first country code' do
      PublicApi.first_code.must_equal 'ZA-EC'
    end
  end

  describe 'all' do
    it 'loads all regions' do
      all = PublicApi.all
      all.size.must_equal(315)
    end

    it 'loads South Africa, United States, United Kingdom, Australia' do
      all = PublicApi.all
      all.map(&:country_name).uniq.must_equal(['South Africa', 'United States', 'United Kingdom', 'Australia'])
    end
  end
end
