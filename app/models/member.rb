# == Schema Information
#
# Table name: members
#
#  old_id            :integer
#  old_price_book_id :integer
#  shopper_id        :integer
#  admin             :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  id                :uuid             not null, primary key
#  price_book_id     :uuid
#

class Member < ApplicationRecord
  belongs_to :shopper

  validates :shopper_id, :price_book_id, presence: true
  validates :shopper_id, uniqueness: { scope: :price_book_id }
end
