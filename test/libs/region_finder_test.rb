require 'test_helper'

describe RegionFinder do
  describe 'first_code' do
    it 'gives first country code' do
      RegionFinder.instance.first_code.must_equal 'AFG-BDS'
    end
  end

  describe 'all' do
    it 'loads all regions' do
      all = RegionFinder.instance
      all.size.must_equal(3776)
    end
  end
end
