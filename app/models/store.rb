# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Store < ActiveRecord::Base
  validates :name, :location, presence: true
end
