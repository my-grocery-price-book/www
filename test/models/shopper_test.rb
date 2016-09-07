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

require 'test_helper'

describe Shopper do
  describe 'to_s' do
    it 'works' do
      Shopper.new.to_s
    end
  end

  describe 'find_or_by_social_profile' do
    it 'creates a new shopper' do
      social_profile = OpenStruct.new(email: 'test@mail.com')
      shopper = Shopper.find_or_by_social_profile(social_profile)
      shopper.must_be :persisted?
      shopper.email.must_equal 'test@mail.com'
      shopper.must_be :confirmed?
    end

    it 'returns existing shopper' do
      existing_shopper = FactoryGirl.create(:shopper, email: 'test1@mail.com')
      social_profile = OpenStruct.new(email: 'test1@mail.com')
      shopper = Shopper.find_or_by_social_profile(social_profile)
      shopper.must_equal(existing_shopper)
      shopper.email.must_equal 'test1@mail.com'
      shopper.must_be :confirmed?
    end
  end
end
