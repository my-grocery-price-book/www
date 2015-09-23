module ShoppingListDecorator
  def created_on
    created_at.to_date
  end

  def items_progress
    "#{done_items.count}/#{items.count}"
  end
end
