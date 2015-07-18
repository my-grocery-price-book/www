# == Schema Information
#
# Table name: regular_items
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  shopper_id :integer
#

class RegularItem < ActiveRecord::Base
  belongs_to :shopper

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :shopper_id

  def self.for_shopper(shopper)
    where(shopper_id: shopper)
  end

end
