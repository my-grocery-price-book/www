module ShoppingListItemDecorator
  def item_div_id
    "#{name.downcase}_item"
  end

  def display_name
    if unit.downcase.include?(name.downcase)
      "#{amount} #{unit}"
    else
      "#{amount} #{unit} #{name}"
    end
  end
end
