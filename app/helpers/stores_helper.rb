# frozen_string_literal: true
# == Schema Information
#
# Table name: stores
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  location    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_code :string           not null
#

module StoresHelper
  def regions_for_book(book)
    RegionFinder.instance.find_by_codes(book.region_codes).map do |region|
      [region.name, region.code]
    end
  end
end
