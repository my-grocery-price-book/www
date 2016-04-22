# == Schema Information
#
# Table name: price_entries
#
#  id                         :integer          not null, primary key
#  date_on                    :date             not null
#  store_id                   :integer
#  product_name               :string           not null
#  amount                     :integer          not null
#  package_size               :integer          not null
#  package_unit               :string           not null
#  price_per_package_in_cents :integer          not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class PriceEntry < ActiveRecord::Base
  belongs_to :store
  validates :date_on, :product_name, :amount, :package_size,
            :package_unit, :price_per_package_in_cents, presence: true
end