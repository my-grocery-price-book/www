# == Schema Information
#
# Table name: price_books
#
#  id         :integer          not null, primary key
#  shopper_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PriceBook < ActiveRecord::Base
  validates :shopper_id, uniqueness: true, presence: true
  has_many :pages, dependent: :delete_all
  belongs_to :shopper

  def self.for_shopper(shopper)
    find_or_create_by(shopper_id: shopper.id)
  end

  def page_count
    pages.count
  end

  def update_product!(info)
    item = pages.find_or_initialize_by(
      category: info[:category],
      name: info[:regular_name],
      unit: info[:package_unit]
    )
    item.product_names << info[:product_brand_name]
    item.save
  end

  def search_pages(term)
    pages.where('name ILIKE ?', "%#{term}%")
  end

  def find_page!(page_id)
    pages.where("CONCAT(LOWER(category),'_',LOWER(unit),'_',LOWER(name)) = ?", page_id).first!
  end
end
