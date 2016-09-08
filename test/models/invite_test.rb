# frozen_string_literal: true
# == Schema Information
#
# Table name: invites
#
#  old_id            :integer
#  old_price_book_id :integer
#  name              :string
#  email             :string
#  status            :string           default("sent"), not null
#  token             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  id                :uuid             not null, primary key
#  price_book_id     :uuid
#

require 'test_helper'

describe Invite do
  describe 'Validation' do
    it 'requires shopper_id' do
      Invite.create.errors[:price_book_id].wont_be_empty
    end

    it 'requires email' do
      Invite.create.errors[:email].wont_be_empty
    end
  end
end
