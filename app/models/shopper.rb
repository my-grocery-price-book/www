# == Schema Information
#
# Table name: shoppers
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  guest                  :boolean          default(FALSE), not null
#

class Shopper < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entry_owners
  has_many :price_entries, through: :entry_owners

  # @param [PriceEntry] entry
  def create_entry_owner!(entry)
    entry_owners.create!(price_entry: entry)
  end

  def password_required?
    return false if new_creating_guest?
    super || guest?
  end

  def email_required?
    !new_creating_guest?
  end

  def valid_password?(*)
    guest? || super
  end

  def to_s
    "<Shopper id:#{id} email:#{email} confirmed:#{confirmed?}/>"
  end

  private

  def new_creating_guest?
    new_record? && guest?
  end
end
