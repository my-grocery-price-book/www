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

class Store < ActiveRecord::Base
  validates :name, :location, :region_code, presence: true

  before_validation :strip_spacing

  def strip_spacing
    name.try(:strip!)
    location.try(:strip!)
  end

  def name_and_location
    "#{name} - #{location}"
  end

  def self.find_or_initialize(args)
    matching_name = args.fetch(:name).downcase.gsub(/\s/, '')
    matching_location = args.fetch(:location).downcase.gsub(/\s/, '')
    find_by('replace(LOWER(name), \' \', \'\') = ? AND replace(LOWER(location), \' \', \'\') = ?
             AND region_code = ?',
            matching_name, matching_location, args.fetch(:region_code)) ||
      new(args)
  end
end
