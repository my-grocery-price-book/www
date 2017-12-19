require 'features_helper'

class BuildShoppingListTest < FeatureTest
  module TrackingShopper
    def add_eggs_entry
      click_link 'Price Book'
      click_on 'Eggs'
      click_on 'New Price'

      # need to select a region first
      set_book_region

      # need to create a new store first
      create_pick_n_pay_store

      # start filling in the price
      complete_sugar_entry
    end

    private

    def complete_sugar_entry
      select 'Pick n Pay - Canal Walk', from: 'Store'
      fill_in 'Product name', with: 'White Eggs'
      fill_in 'Amount', with: '1'
      fill_in 'Package size', with: '1'
      fill_in 'Total price', with: '3.5'
      click_on 'Save'
    end
  end

  module ShoppingListManager
    def create_shopping_list(assertor)
      assertor.assert has_text?('Shopping List')
      click_on 'New Shopping List'
    end

    def add_items_to_shopping_list(assertor)
      add_items('bread', 'eggs', 'milk')
      %w[bread eggs milk].each do |item_name|
        assertor.assert has_text?(item_name)
      end
    end

    def update_items_on_shopping_list(assertor)
      purchase_bread
      delete_eggs

      using_wait_time(6) do
        assertor.assert has_no_text?('eggs')
        %w[bread milk].each do |item_name|
          assertor.assert has_text?(item_name)
        end
      end
    end

    private

    def add_items(*item_names)
      item_names.each do |item_name|
        add_item(item_name)
      end
    end

    def add_item(item_name)
      fill_in 'Item name', with: item_name
      click_button 'Add'
    end

    def purchase_bread
      within('[data-item-name="bread"]') do
        click_on 'purchased'
      end
    end

    def delete_eggs
      within('[data-item-name="eggs"]') do
        click_on 'delete'
        click_on 'OK' # confirm the delete
      end
    end
  end

  def create_shopping_list(shopper)
    shopper.create_shopping_list(self)
    shopper.add_items_to_shopping_list(self)
    shopper.update_items_on_shopping_list(self)
  end

  test 'create shopping list as logged in shopper with no price book entries' do
    @shopper = ShopperPersonaSession.new(email: 'shopper@example.com').extend(ShoppingListManager)

    @shopper.sign_up
    @shopper.perform do
      visit '/shopping_lists'
    end
    create_shopping_list(@shopper)
  end

  test 'create shopping as guest with price book entries' do
    @guest = ShopperPersonaSession.new.extend(ShoppingListManager).extend(TrackingShopper)
    @guest.perform do
      visit '/shopping_lists'
      click_button 'Log in as Guest'
    end

    @guest.add_eggs_entry
    @guest.visit '/shopping_lists'
    create_shopping_list(@guest)
  end
end
