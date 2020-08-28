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
  self.ignored_columns = %w[old_id encrypted_password reset_password_token reset_password_sent_at
                            remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last
                            sign_in_ip confirmation_token confirmed_at confirmation_sent_at unconfirmed_email]

  validates :email, uniqueness: { allow_blank: true }

  def to_s
    "<Shopper id:#{id} email:#{email} />"
  end
end
