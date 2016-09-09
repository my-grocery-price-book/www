# frozen_string_literal: true
# == Schema Information
#
# Table name: shoppers
#
#  old_id                 :integer
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
#  id                     :uuid             not null, primary key
#

class Shopper < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # @param [SocialProfile] social_profile
  # @return [Shopper]
  def self.find_or_create_for_social_profile(social_profile)
    find_or_initialize_by(email: social_profile.email).tap do |shopper|
      shopper.create_for_social_profile
    end
  end

  def create_for_social_profile
    self.password = SecureRandom.hex if new_record?
    skip_confirmation! unless confirmed?
    save!
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
