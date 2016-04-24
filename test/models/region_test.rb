require 'test_helper'

describe Region do
  describe 'first_code' do
    it 'gives first country code' do
      Region.first_code.must_equal 'ZA-EC'
    end
  end

  describe 'all' do
    it 'loads all regions' do
      all = Region.all
      all.size.must_equal(315)
    end

    it 'loads South Africa, United States, United Kingdom, Australia' do
      all = Region.all
      all.map(&:country_name).uniq.must_equal(['South Africa', 'United States', 'United Kingdom', 'Australia'])
    end
  end
end
