module ShoppingListDecorator
  def title
    super || created_at.to_date
  end

  def items_progress
    "./."
  end
end
