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
    find_by('replace(name, \' \', \'\') ILIKE ? AND replace(location, \' \', \'\') ILIKE ? AND region_code = ?',
            args.fetch(:name).gsub(/\s/, ''), args.fetch(:location).gsub(/\s/, ''), args.fetch(:region_code)) ||
      new(args)
  end
end
