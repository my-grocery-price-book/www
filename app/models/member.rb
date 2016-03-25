# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  price_book_id :integer
#  shopper_id    :integer
#  admin         :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Member < ActiveRecord::Base
  belongs_to :shopper

  validates :shopper_id, :price_book_id, presence: true
end
