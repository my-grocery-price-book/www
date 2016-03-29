# == Schema Information
#
# Table name: invites
#
#  id            :integer          not null, primary key
#  price_book_id :integer
#  name          :string
#  email         :string
#  status        :string           default("sent"), not null
#  token         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'securerandom'

class Invite < ActiveRecord::Base
  belongs_to :price_book

  validates :price_book_id, :email, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/, allow_blank: true

  before_create do
    self.token = SecureRandom.urlsafe_base64
  end

  delegate :name, to: :price_book, prefix: true

  def to_param
    token
  end

  # @param [String] token
  def self.find_by_token(token)
    find_by(token: token)
  end

  def token_invalid?
    status == 'accepted' || status == 'rejected'
  end

  def token_valid?
    !token_invalid?
  end

  # @param [Shopper] shopper
  def accept_by(shopper)
    price_book.add_member(shopper)
    update(status: 'accepted')
  end

  def reject
    update(status: 'rejected')
  end
end
