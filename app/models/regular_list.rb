# == Schema Information
#
# Table name: regular_lists
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RegularList < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

end
